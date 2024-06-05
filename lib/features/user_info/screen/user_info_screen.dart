import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/Screen/login_screen.dart';
import '../../auth/bloc/auth_bloc.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Center(child: const Text('DashBoard')),
        actions: <Widget>[
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStateStatus.logout) {
            Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == AuthStateStatus.error) {
              return Center(child: Text(state.errorMessage ?? 'Unknown error'));
            } else if (state.user != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Text('Username: ${state.user!.yearOfAdmission}'),
                    Text('User ID: ${state.user!.userId}'),
                    Text('Email: ${state.user!.userEmailId}'),
                    Text('Student Name: ${state.user!.studentName}'),
                    Text('Student Roll No: ${state.user!.studentRollNo}'),
                    Text('Student Year: ${state.user!.studentYear}'),
                    Text('Student Branch: ${state.user!.studentBranch}'),
                    Text('Is Student Verified: ${state.user!.isStudentVerified}'),*/
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: Colors.black12,
                            ),


                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    ClipOval(
                                      child: ClipRRect(
                                        child: Container(
                                          color: Colors.grey,
                                          height: 80,
                                          width: 80,
                                          child: Image.network("https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=BpR0FVaEa5F24GIw7K8nMWiiGmbb8qmhfkpXcp1dhQg="),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 40,),
                                    Column(
                                      children: [
                                        Text("${state.user!.studentName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),),
                                        SizedBox(height: 5,),
                                        Text("${state.user!.studentYear}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),)
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 18,),
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Branch  -   ${state.user!.studentBranch}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                      SizedBox(height: 10,),
                                      Text("Email  -      ${state.user!.userEmailId}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                      SizedBox(height: 10,),
                                      Text("Roll No.  -     ${state.user!.studentRollNo}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                      SizedBox(height: 10,),
                                      Text("Year of admission  -   ${state.user!.yearOfAdmission}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text("Status  - ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                                          SizedBox(width: 12,),
                                          Text(!state.user!.isStudentVerified! ? "Pending" : "Verified",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:  !state.user!.isStudentVerified! ? Colors.red : Colors.green),)
                                        ],
                                      )

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Table(
                          border: TableBorder.all(color: Colors.black,width: .8,borderRadius: BorderRadius.circular(11)),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FixedColumnWidth(70),
                            1: FixedColumnWidth(70),
                            2: FixedColumnWidth(70),
                            3: FixedColumnWidth(70),
                            4: FixedColumnWidth(70),
                          },
                          children: [
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Center(child: Text("YEARS",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text("Academic Fee ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text("Mess Fee ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text("Mess Caution Fee ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text("Maintainance Fee ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: Text("1st year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("62300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("30000 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("5000",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.red),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: Text("2nd year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("62300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("30000 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("--",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.red),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: Text("3rd year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("62300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("30000 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("--",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.red),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: Text("4th year",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("62300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("30000 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("--",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.red),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("300",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                                  ),
                                ]
                            ),
                            TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: Text("Status",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.5),
                                    child: ElevatedButton(onPressed: (){},style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ) ,child: Text("View")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.5),
                                    child: ElevatedButton(onPressed: (){},style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ) ,child: Text("View")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ElevatedButton(onPressed: (){},style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                    ) ,child: Text("Due")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.5),
                                    child: ElevatedButton(onPressed: (){},style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    ) ,child: Text("View")),
                                  ),
                                ]
                            ),

                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No user information available'));
            }
          },
        ),
      ),
    );
  }
}