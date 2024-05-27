import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/viwe_pdf.dart';
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
          if(state.getStatus == FeeReceiptGetStatus.loaded){
            return Center(
              child: state.feeReceiptModelList != null
                  ? ListView.builder(
                      itemCount: state.feeReceiptModelList!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.feeReceiptModelList![index].receiptName!),
                          subtitle: Text(state.feeReceiptModelList![index].receiptYear!),
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
        FloatingActionButton(
          onPressed: () {
            context.read<FeeReceiptBloc>().add(UploadImageEvent(
                folderName: 'your_folder_name',
                receiptName: 'your_receipt_name',
                receiptYear: 'your_receipt_year',
                receiptAmount: 'your_receipt_amount'));

            //_addNewReceipt(context);
          },
          child: const Icon(Icons.cloud_upload),
          heroTag: 'imageUpload',
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {
            context
                .read<FeeReceiptBloc>()
                .add(UploadPDFEvent( folderName: 'your_folder_name',
                receiptName: 'your_receipt_name',
                receiptYear: 'your_receipt_year',
                receiptAmount: 'your_receipt_amount'));
          },
          child: const Icon(Icons.picture_as_pdf),
          heroTag: 'pdfUpload',
        ),
      ],
    ),

    );
  }

  Widget _addNewReceipt(BuildContext context) {

    String? receiptName = "";
    String? receiptYear = "";
    String? receiptAmount = "";


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
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Receipt Name'),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter a receiptName'
                          : null,
                      onSaved: (value) => receiptName = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Receipt Year'),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter a Year'
                          : null,
                      onSaved: (value) => receiptYear = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Receipt Amount'),
                      validator: (value) => value!.isEmpty
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
                    child: const Text('Add'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<FeeReceiptBloc>()
                            .add(UploadPDFEvent( folderName: 'your_folder_name',
                            receiptName: receiptName!,
                            receiptYear: receiptYear!,
                            receiptAmount: receiptAmount!));

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
