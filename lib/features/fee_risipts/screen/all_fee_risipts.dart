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
      )

      // body: BlocBuilder<FeeReceiptBloc, FeeReceiptState>(
      //   builder: (context, state) {
      //     if (state.postStatus == FeeReceiptPostStatus.loading) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (state.postStatus == FeeReceiptPostStatus.imageLoaded) {
      //       return Center(
      //         child: state.feeReceiptModel?.receiptUrl != null
      //             ? Image.network(state.feeReceiptModel?.receiptUrl ?? '')
      //             : Text('No image uploaded'),
      //       );
      //     }
      //     if (state.postStatus == FeeReceiptPostStatus.pdfLoaded) {
      //       return Center(
      //         child: state.feeReceiptModel?.receiptUrl != null
      //             ? ViewPDF(url: state.feeReceiptModel?.receiptUrl ?? '')
      //             : Text('No PDF uploaded'),
      //       );
      //     }
      //     return const Center(
      //       child: Text('All Fee receipts'),
      //     );
      //   },
      // ),
    );
  }
}
