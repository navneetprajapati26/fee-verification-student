import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constents/constents.dart';
import '../../../widget/dropdown_button.dart';
import '../../../widget/viwe_pdf.dart';
import '../../../widget/year_picker.dart';
import '../bloc/fee_receipt_bloc.dart';

class AllFeeReceipt extends StatefulWidget {
  const AllFeeReceipt({Key? key}) : super(key: key);

  @override
  State<AllFeeReceipt> createState() => _AllFeeReceiptState();
}

class _AllFeeReceiptState extends State<AllFeeReceipt> {

  @override
  void initState() {
    context.read<FeeReceiptBloc>().add(GetFeeReceiptsByListOfIdEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Fee receipts'),
      ),

      body: BlocBuilder<FeeReceiptBloc, FeeReceiptState>(
        builder: (context, state) {
          if (state.getStatus == FeeReceiptGetStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.getStatus == FeeReceiptGetStatus.loaded) {
            return Center(
              child: state.feeReceiptModelList != null
                  ? ListView.builder(
                itemCount: state.feeReceiptModelList!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: leadingIcon(
                        state.feeReceiptModelList![index].receiptStatus!),
                    title: Text(state.feeReceiptModelList![index].receiptType!),
                    subtitle: Text("${state.feeReceiptModelList![index]
                        .receiptYear!} ${state.feeReceiptModelList![index]
                        .receiptStatus!}"),
                  );
                },
              )
                  : Text('No image uploaded'),
            );
          }
          return const Center(
            child: Text('All Fee receipts'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<FeeReceiptBloc, FeeReceiptState>(
            builder: (context, state) {
              return FloatingActionButton(
                onPressed: () {
                  // context.read<FeeReceiptBloc>().add(UploadImageEvent(
                  //     folderName: 'your_folder_name',
                  //     receiptName: 'your_receipt_name',
                  //     receiptYear: 'your_receipt_year',
                  //     receiptAmount: 'your_receipt_amount'));

                  if (state.studentModel!.isStudentVerified!) {
                    showDialog(
                      context: context,
                      builder: (context) => _addNewReceipt(context),
                    );
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "You are not a verifier connect your Department",
                        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                        gravity: ToastGravity.BOTTOM, // or ToastGravity.CENTER, ToastGravity.TOP
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: const Icon(Icons.cloud_upload),
                heroTag: 'imageUpload',
              );
            },
          ),
          // SizedBox(height: 10),
          // FloatingActionButton(
          //   onPressed: () {
          //     context
          //         .read<FeeReceiptBloc>()
          //         .add(UploadPDFEvent( folderName: 'your_folder_name',
          //         receiptName: 'your_receipt_name',
          //         receiptYear: 'your_receipt_year',
          //         receiptAmount: 'your_receipt_amount'));
          //   },
          //   child: const Icon(Icons.picture_as_pdf),
          //   heroTag: 'pdfUpload',
          // ),
        ],
      ),

    );
  }

  Widget leadingIcon(String? receiptStatus) {
    if (receiptStatus == ListConstent.FeeReceiptStatus[0]) {
      return Container(decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.yellow), child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Icons.padding_outlined, color: Colors.black,),
      ));
    }
    if (receiptStatus == ListConstent.FeeReceiptStatus[1]) {
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.approval_rounded, color: Colors.white,),
        ),
      );
    }
    if (receiptStatus == ListConstent.FeeReceiptStatus[2]) {
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.close, color: Colors.white,),
        ),
      );
    }

    return SizedBox();
  }

  Widget _addNewReceipt(BuildContext context) {
    log("in addNewReceipt", name: "addNewReceipt");

    String? receiptType = "";
    String? receiptYear = "";
    String? receiptAmount = "";
    String? receiptNumber = "";


    final _formKey = GlobalKey<FormState>();
    return Dialog(
      surfaceTintColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [


                    CustomDropdownButton(
                      items: ListConstent.feeType,
                      hint: 'Select fee Type',
                      onChanged: (value) {
                        setState(() {
                          receiptType = value!;
                        });

                        print('Selected: $receiptType');
                      },
                    ),
                    SizedBox(height: 10,),

                    YearPickerWidget(
                      startYear: 2000,
                      endYear: 2030,
                      onYearChanged: (year) {
                        print('Selected Year: $year');

                        setState(() {
                          receiptYear = year.toString();
                        });
                      },
                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Receipt number'),
                      validator: (value) =>
                      value!.isEmpty
                          ? 'Please enter a receipt number'
                          : null,
                      onSaved: (value) => receiptNumber = value!,
                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Receipt Amount'),
                      validator: (value) =>
                      value!.isEmpty
                          ? 'Please enter a receipt amount'
                          : null,
                      onSaved: (value) => receiptAmount = value,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: const Text('Add Doc'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<FeeReceiptBloc>()
                            .add(UploadImageEvent(
                            folderName: 'your_folder_name',
                            receiptType: receiptType!,
                            receiptYear: receiptYear!,
                            receiptAmount: receiptAmount!,
                            receiptNumber: receiptNumber!
                        ));

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }

}
