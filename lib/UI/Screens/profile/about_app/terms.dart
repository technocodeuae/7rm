import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../conset/Const.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
              color: Color1, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          color: Color1,
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),

      body: Stack(
        children: [
          Image.asset(
            'assets/images/main/image 12.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              Container(height:680.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.sp))
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.sp),
                    margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.3),
                      border: Border.all(
                        color: Colors.purple.withOpacity(0.8),
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.sp),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seven RM LLC Terms & Conditions\n\n\n1. TERMS OF SALE. All payments be made in full to Seven RM LLC. Cash, Check (with bank letter of guarantee), or credit card. A 3% Administration fee will be added to all credit card purchases. A 200 AED fee will be charged on all returned checks. Appropriate legal services will be obtained to secure the performance of any check given and no exceptions will be made. Under no circumstances will the purchaser stop payment of a check. In the event that a horse purchased is returned, the purchaser will receive a full refund from Seven RM LLC.  \n\n\n1A. ALL WINNING INTERNET BIDS will incur a 4% online Buyers Premium  \n\n\n1B. All internet bidders must place a valid credit/debit card on file with Seven RM LLC in order to be approved for online bidding. At that time, Seven RM LLC will place a 2000 AED pre-authorization on that card. This is NOT a charge (though some mobile banking apps will send a notification at the time of authorization that looks like a charge - again it is NOT a charge). This authorization will fall off and "disappear" at the conclusion of the auction for all registered bidders who WERE NOT successful winning bidders. For those online bidders who are successful, this pre-authorization will be released once final payment for purchases is confirmed received by Legacy Livestock. Bidding online is the same as bidding in person and is a legally binding agreement. In the event that a winning online bidder fails to complete the transaction by making final payment to Sevenx RM LLCas outlined in Clause 1 above, Horse Auctions USA WILL NOT release this pre-authorization but rather, will complete it and the online bidder agrees to forfeit the 2000 AED. Further, online bidders understand and acknowledge that failure to complete a transaction does NOT absolve them from the financial obligation of being the winning bidder and is aware that Seven RM LLC reserves the right to charge the total amount owed to Sevenx RM LLC for winning bids to the registered card to resolve the debt owed by the bidder to Legacy Livestock Auction. Should this unfortunate step become necessary, you will have all future bidding privileges online with Seven RM LLC revoked permanently.\n\n\n2. SOUNDNESS AGREEMENT. Consignor has the responsibility to inform the sale company of any unsoundness a horse may have. Cribbers, Windsuckers, stall weavers, and cryptorchids must also be identified. Mental attitudes, fears, behaviors, illness and death are not included in this agreement. There is no guarantee on horses sold AS IS or any horse selling for 5500 AED or less. Horses sold SOUND are subject to a veterinary examination at the purchasers expense if believed to be not sound. The exam will exclude all physical defects stated by the consignor and will be limited to the horses current condition. THE FAILURE OF FLEXION TESTS WILL NOT BE CONSIDERED REASON TO RETURN A HORSE. X-RAYS WILL BE REQUIRED. The results must be completed and reported to Seven RM LLC within 72 hours of sale. A written Veterinary certificate is required. It is the purchaser\'s responsibility to provide safe Transportation and have proper facilities to maintain the horse prior to veterinary examination. If a horse is returned, it must be brought to the auction barn in acceptable condition. No new Lumps, Bumps, scrapes or bite marks. Transportation done for or by the purchaser is at their own expense.\n\n\n3. PAYMENTS ON HORSES SOLD. The consignor\'s check will be held for three days after the sale. To insure prompt delivery of your check, be sure Seven RM LLC has your full name and proper mailing address. In the event a horse is returned, the consignor is responsible for paying commission on the selling price of that horse and any other sale fees incurred. The Horse will remain property of Seven RM LLC until these fees are paid. The purchaser will be given a full refund from Sevenx RM LLC on any horse returned.\n\n\n4. COGGINS TEST. All horses consigned to the auction will be subject to a Coggins test. Blood samples will be drawn the day of the auction sale at the purchaser\'s expense. In the event that a horse is a "No Sale", the consignor is responsible for the expense.\n\n\n5. POSITIVELY NO PRIVATE DEALING OF HORSES IS PERMITTED IN THE SALE BARN OR SALE COMPANY PROPERTY.\n\n\n6. TACK, MERCHANDISE, TRAILERS, Equipment, HAY ETC. Seven RM LLC does not guarantee any of the above listed items. It is the sole responsibility of the purchaser to examine items prior to bidding. Sevenx RM LLC is not responsible for lost, stolen or damaged items. Any unclaimed items by the end of the sale will be sold at the following sale as property of Seven RM LLC.\n\n\n7. CAUTION. Everyone attending this sale agrees to save and hold harmless and indemnify Seven RM LLC, employees, and representatives',
                           style: TextStyle(
                              fontSize: 14.sp
                          ),
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
