import 'package:aapka_vakeel/model/user.dart';
import 'package:aapka_vakeel/utilities/custom_button.dart';
import 'package:aapka_vakeel/utilities/custom_text.dart';
import 'package:aapka_vakeel/utilities/my_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_call/video_call.dart';

class TrademarkDetail extends StatefulWidget {
  String trademarkType="";
  TrademarkDetail({super.key,required this.trademarkType});

  @override
  State<TrademarkDetail> createState() => _TrademarkDetailState();
}

class _TrademarkDetailState extends State<TrademarkDetail> {
  Map<String, List<String>> documentsRequired = {
  "Patent Registration": [
    "Application Form (Form 1)",
    "Provisional or Complete Specification (Form 2)",
    "Provisional specification is filed if the invention is still under development; a complete specification is filed when the invention is ready.",
    "Statement and Undertaking (Form 3)",
    "Declaration as to Inventorship (Form 5)",
    "Power of Attorney (if an agent is filing the application on behalf of the inventor)",
    "Priority Document (if claiming priority from an earlier application filed in a foreign country)",
    "Proof of Right to File (if the applicant is not the inventor)",
    "Drawings (if any, to illustrate the invention)",
    "Abstract of the Invention",
    "Fee Payment Receipt"
  ],
  "Trademark Registration": [
    "Trademark Application Form (Form TM-A)",
    "Proof of Business Registration (Certificate of Incorporation, Partnership Deed, etc.)",
    "Details of the Applicant (Name, address, nationality, and nature of business)",
    "Representation of the Trademark (Logo, symbol, wordmark, or slogan)",
    "List of Goods/Services under which the trademark is to be registered",
    "Power of Attorney (if filed by an agent or attorney)",
    "Priority Document (if claiming priority from an international application)",
    "User Affidavit (if the trademark is already in use)",
    "Fee Payment Receipt"
  ],
  "Copyright Registration": [
    "Application Form (Form XIV for literary, dramatic, musical, or artistic work)",
    "Copies of the Work (2 copies of the artistic/literary/musical/dramatic work)",
    "No Objection Certificate (NOC) from the author (if the applicant is different from the author)",
    "Details of the Work (Title, nature, and description of the work)",
    "Power of Attorney (if filed by an agent)",
    "Fee Payment Receipt",
    "Proof of Work Published (if already published)",
    "Authorization Letters (if applicable)"
  ],
  "Design Registration": [
    "Design Application Form (Form 1)",
    "Representation Sheets (6 copies of the drawings or photographs of the design from different views)",
    "Statement of Novelty (a brief description of how the design is new and original)",
    "Class of Design (according to the Locarno classification)",
    "Power of Attorney (if filed by an agent or attorney)",
    "Priority Document (if claiming priority from an earlier international application)",
    "Fee Payment Receipt"
  ],
  "Geographical Indication (GI) Registration": [
    "Application Form (Form GI-1)",
    "Statement of Case (describing how the product qualifies for GI protection)",
    "Details of the Producer/Applicant",
    "Class of Goods under the GI (agricultural, manufactured, etc.)",
    "Proof of Origin (showing the link between the product and its geographical origin)",
    "Power of Attorney (if filed by an agent or attorney)",
    "Affidavit of Applicant",
    "Fee Payment Receipt",
    "Historical and Geographical Proof (of the product’s link to the location)"
  ],
  "Trade Secret Protection": [
    "Non-Disclosure Agreements (NDAs) with employees, business partners, etc.",
    "Confidentiality Policies",
    "Employment Contracts (with confidentiality clauses)",
    "Proof of Internal Security Measures (like restricted access to confidential information)"
  ],
  "Plant Variety Protection": [
    "Application Form (for the registration of new plant varieties)",
    "Description of the Variety (its distinctness, uniformity, and stability)",
    "Test Report (showing the variety has been tested for uniqueness)",
    "Proof of Ownership (if the applicant is not the breeder)",
    "Power of Attorney (if filed by an agent)",
    "Deposit of Seed or Plant Material",
    "Fee Payment Receipt"
  ],
  "Integrated Circuit Layout Design Registration": [
    "Application Form (for registering a layout design)",
    "Layout Design Description (showing the design of the integrated circuit)",
    "Statement of Novelty (explaining the originality of the layout)",
    "Power of Attorney (if filed by an agent)",
    "Fee Payment Receipt"
  ],
};
 

  bool IsIntro= true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar.appbar(context,head: "Patent Registration"),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
          Container(
            padding: EdgeInsets.all(12),
            color: Color(0xFFD9D9D9),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              IsIntro?Expanded(child:customButton.taskButton("Introduction", (){})):Expanded(child:customButton.textButton("Introduction", (){
                setState(() {
                  IsIntro=true;
                });
              })),
              SizedBox(width: 5)
              ,!IsIntro?Expanded(child:customButton.taskButton("Documents", (){})):Expanded(child:customButton.textButton("Documents", (){
                setState(() {
                  IsIntro=false;
                });
              }))
            ],),
          ),
          introDocuments(),
          SizedBox(height: 10),
          customButton.taskButton("Join Call", (){
   Navigator.of(context).pushReplacement(
                 MaterialPageRoute(
                  builder: (context) =>JoinScreen(username: userClass.displayName,meetingId: userClass.uid+"trademark:"+widget.trademarkType,
                  isJoin: false,
                  )
                  // VideoCall(data: snapshot.data!),
                 ));
          })
          ],
        ),
      ),

    );
  }
  introDocuments(){
    return Container(
      height: MediaQuery.of(context).size.height-200,
      child: IsIntro? getIntroduction()
      :getDocumentsList()
      ,
    );
  }
   getDocumentsList(){
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height-100,
            child: ListView.builder(
                                      itemCount: documentsRequired[widget.trademarkType]!.length,
                                      itemBuilder: (context, index) {
                                        return  
                                        GestureDetector(
                                          onTap: (){
                                            
                                //             Navigator.push(
                                // context,
                                // PageTransition(
                                //     child: TrademarkDetail(),
                                //     type: PageTransitionType.rightToLeft));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Card(
                                              elevation: 4,
                                            color: Color(0xFFF0F0F0), // Sets the elevation to create shadow
                                            shadowColor: Colors.grey, // Sets shadow color to grey
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10), // Optional: Rounds the corners
                                            ),
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          CustomText.RegularDarkText(documentsRequired[widget.trademarkType]![index])]),
        
                                                                      ),
                                              ),
                                            ),
                                          // ),
                                        );
                                      },
                                    ),
          ),
        );
                  
  }
  getIntroduction(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(22),
              height: MediaQuery.of(context).size.height-100,
        child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: '1. Encourages Innovation and Creativity\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- By protecting inventions, artistic works, and designs, IPR incentivizes individuals and companies to innovate without fear of their ideas being copied or stolen. This leads to the growth of new technologies, products, and creative content.\n\n',
                  ),
                  TextSpan(
                    text: '2. Economic Growth\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- IPR contributes to economic development by fostering industries that rely on innovation and creativity, such as technology, pharmaceuticals, and entertainment. Protected intellectual property can be commercialized, creating new markets and job opportunities.\n\n',
                  ),
                  TextSpan(
                    text: '3. Brand Protection\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- Trademarks and GIs help businesses establish a unique identity, build brand recognition, and maintain consumer trust. They also prevent unfair competition by ensuring that only the rightful owner can benefit from the reputation associated with the brand or geographical origin.\n\n',
                  ),
                  TextSpan(
                    text: '4. Prevents Unauthorized Use\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- Copyrights and patents prevent unauthorized use, reproduction, or distribution of creative works and inventions, ensuring that the original creator is adequately compensated for their efforts.\n\n',
                  ),
                  TextSpan(
                    text: '5. Enhances International Trade\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- IPR facilitates international trade by providing a legal framework for resolving disputes and ensuring that intellectual property is respected across borders. This encourages foreign investment and collaborations.\n\n',
                  ),
                  TextSpan(
                    text: '6. Promotes Consumer Confidence\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        '- By ensuring authenticity and quality, especially in trademark and GI-protected products, IPR gives consumers confidence in the goods they purchase. This protection prevents counterfeiting and ensures that consumers get genuine products.\n\n',
                  ),
                ],
              ),
            ),
      ),
    );
  }
}