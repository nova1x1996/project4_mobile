import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';

class PaymentHistory extends StatefulWidget {
  static const routeName = "/PaymentHistory";

  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(
          "Payment History",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: bgColor1,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => HistoryCard(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: 5),
              HistoryCard(),
            ],
          ),
        )),
      ),
    );
  }

  Container HistoryCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Column(
            children: [
              HistoryCardHeader(),
              Divider(
                height: 1,
                color: bgColor1,
              ),
              HistoryCardContent(),
              Divider(
                height: 1,
                color: bgColor1,
              ),
              HistoryCardButton(),
            ],
          )
        ],
      ),
    );
  }

  Padding HistoryCardButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: bgColor1,
              border: Border.all(color: colorPrimary),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "APPOINTMENT DETAILS",
            style: TextStyle(color: colorPrimary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Container HistoryCardContent() {
    return Container(
      height: 80,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Date",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              Text("17 May, 2020",
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          VerticalDivider(
            width: 1,
            color: bgColor1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Time",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500)),
              Text(
                "17:00 PM",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding HistoryCardHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: bgColor1, borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.credit_card_outlined,
              color: colorPrimary,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("\$ 100",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              Text(
                "Visa",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
