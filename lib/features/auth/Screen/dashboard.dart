import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Center(child: Text("Dashboard"))
      ),
      body: Column(
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
                            child: Image.asset("assets/images/image11.png",fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                      SizedBox(width: 40,),
                      Column(
                        children: [
                          Text("John Doe",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),),
                          SizedBox(height: 5,),
                          Text("Final Year",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),)
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
                        Text("Branch  -   Computer Science Engineering",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                        SizedBox(height: 10,),
                        Text("Email  -      ayush@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                        SizedBox(height: 10,),
                        Text("Phone  -     9084084784",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                        SizedBox(height: 10,),
                        Text("Address  -   xyz, 231206",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("Status  - ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                            SizedBox(width: 12,),
                            Text("Pending ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red),)
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
    );
  }
}