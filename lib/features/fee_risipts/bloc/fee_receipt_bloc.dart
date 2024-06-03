import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constents/constents.dart';
import '../../../utils/storage_utils.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/model/student_model.dart';
import '../../auth/repo/auth_rapo.dart';
import '../model/fee_receipt_model.dart';
import '../repo/fee_receipt_repo.dart';

part 'fee_receipt_event.dart';
part 'fee_receipt_state.dart';

class FeeReceiptBloc extends Bloc<FeeReceiptEvent, FeeReceiptState> {
  final StorageUtils _storageUtils = StorageUtils();
  final FeeReceiptRepository _feeReceiptRepository = FeeReceiptRepository();
  final AuthBloc _authBloc;

  FeeReceiptBloc(this._authBloc) : super(FeeReceiptState.initial()) {
    _authBloc.add(GetUserModel());
    AuthState authState = _authBloc.state;

    log(authState.user.toString(), name: "from FeeReceiptBloc User");

    on<UploadImageEvent>((event, emit) async {
      emit(state.copyWith(
        postStatus: FeeReceiptPostStatus.loading,
        getStatus: FeeReceiptGetStatus.loading,
      ));
      // try {

      _authBloc.add(GetUserModel());
      AuthState authState = _authBloc.state;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      String? imageUrl = await _storageUtils.uploadImage(FolderName.images);

      log(userId!, name: "user ID");

      FeeReceiptModel feeReceiptModel = FeeReceiptModel(
          receiptUrl: imageUrl,
          studentId: userId,
          receiptType: event.receiptType,
          receiptYear: event.receiptYear,
          receiptAmount: event.receiptAmount,
          receiptNum: event.receiptNumber );

      FeeReceiptModel addedFeeReceiptModel =
          await _feeReceiptRepository.addFeeReceipt(feeReceiptModel);

      var studentFeeReceiptsIdList = authState.user!.studentFeeReceiptsIdList;
      studentFeeReceiptsIdList!.add(addedFeeReceiptModel.id!);

      _authBloc.add(UpdateUserInfo(authState.user!
          .copyWith(studentFeeReceiptsIdList: studentFeeReceiptsIdList)));

      List<FeeReceiptModel> feeReceipts = await getFeeReceipts();

      emit(state.copyWith(
        postStatus: FeeReceiptPostStatus.imageLoaded,
        feeReceiptModel: addedFeeReceiptModel,
        getStatus: FeeReceiptGetStatus.loaded,
        feeReceiptModelList: feeReceipts,
      ));
      // } catch (e) {
      //   log(e.toString(), name: "Error");
      //   // Handle error here
      // }
    });

    on<UploadPDFEvent>((event, emit) async {
      emit(state.copyWith(postStatus: FeeReceiptPostStatus.loading));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      try {
        String? pdfUrl = await _storageUtils.uploadPDF(event.folderName);

        FeeReceiptModel feeReceiptModel = FeeReceiptModel(
            receiptUrl: pdfUrl,
            studentId: userId,
            receiptType: event.receiptName,
            receiptYear: event.receiptYear,
            receiptAmount: event.receiptAmount);

        FeeReceiptModel addedFeeReceiptModel =
            await _feeReceiptRepository.addFeeReceipt(feeReceiptModel);

        var studentFeeReceiptsIdList = authState.user!.studentFeeReceiptsIdList;
        studentFeeReceiptsIdList!.add(addedFeeReceiptModel.id!);

        _authBloc.add(UpdateUserInfo(authState.user!
            .copyWith(studentFeeReceiptsIdList: studentFeeReceiptsIdList)));

        List<FeeReceiptModel> feeReceipts = await getFeeReceipts();

        emit(state.copyWith(
          postStatus: FeeReceiptPostStatus.pdfLoaded,
          feeReceiptModel: addedFeeReceiptModel,
          getStatus: FeeReceiptGetStatus.loaded,
          feeReceiptModelList: feeReceipts,
        ));

        // emit(state.copyWith(
        //   postStatus: FeeReceiptPostStatus.pdfLoaded,
        //   feeReceiptModel: state.feeReceiptModel!.copyWith(receiptUrl: pdfUrl),
        // ));
      } catch (e) {
        // Handle error here
      }
    });

    on<GetFeeReceiptsByListOfIdEvent>((event, emit) async {
      emit(state.copyWith(getStatus: FeeReceiptGetStatus.loading));

      //try {

      // final AuthRepository authRepository = AuthRepository();
      //
      // StudentModel? studentModel = await authRepository.getUserInfo();
      //
      // List<String> feeReceiptIds = studentModel!.studentFeeReceiptsIdList!;
      //
      // List<FeeReceiptModel> feeReceipts = await _feeReceiptRepository.getFeeReceiptsByIds(feeReceiptIds: feeReceiptIds);
      //
      List<FeeReceiptModel> feeReceipts = await getFeeReceipts();

      final AuthRepository authRepository = AuthRepository();

      StudentModel? studentModel = await authRepository.getUserInfo();
      emit(state.copyWith(
        getStatus: FeeReceiptGetStatus.loaded,
        feeReceiptModelList: feeReceipts,
        studentModel: studentModel
      ));
      // } catch (e) {
      //   // Handle error here
      // }
    });
  }

  Future<List<FeeReceiptModel>> getFeeReceipts() async {
    final AuthRepository authRepository = AuthRepository();

    StudentModel? studentModel = await authRepository.getUserInfo();

    List<String> feeReceiptIds = studentModel!.studentFeeReceiptsIdList!;

    List<FeeReceiptModel> feeReceipts = await _feeReceiptRepository
        .getFeeReceiptsByIds(feeReceiptIds: feeReceiptIds);

    return feeReceipts;
  }
}
