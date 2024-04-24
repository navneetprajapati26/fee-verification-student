import 'package:flutter/material.dart';
class AllFeeReceipt extends StatefulWidget {
  const AllFeeReceipt({super.key});

  @override
  State<AllFeeReceipt> createState() => _AllFeeReceiptState();
}

class _AllFeeReceiptState extends State<AllFeeReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Fee receipts'),
      ),
      body: const Center(
        child: Text('All Fee receipts'),
      ));
  }
}
