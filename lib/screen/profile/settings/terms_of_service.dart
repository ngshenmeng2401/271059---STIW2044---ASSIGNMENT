import 'package:flutter/material.dart';


class TermsServiceScreen extends StatefulWidget {
  @override
  _TermsServiceScreenState createState() => _TermsServiceScreenState();
}

class _TermsServiceScreenState extends State<TermsServiceScreen> {

  var text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title:Text("Terms of Sevice",style: TextStyle(fontFamily: 'Arial',color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text("INTRODUCTION",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height:20),
                  Text("Welcome to Little Cake Story!",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text: new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "The Little Cake Story website located at "
                        ),
                        new TextSpan(
                          text: "https://www.littlecakestory.com ",
                          style: TextStyle(color: Colors.blue[200])
                        ),
                        new TextSpan(
                          text: "is a copyrighted work belonging to UUM. Certain features of the Site may be subject to additional guidelines, terms, or rules, which will be posted on the Site in connection with such features."
                        ),
                      ]
                  )),
                  SizedBox(height:10),
                  Text("All such additional terms, guidelines, and rules are incorporated by reference into these Terms."),
                  SizedBox(height:10),
                  Text("These Terms of Use described the legally binding terms and conditions that oversee your use of the Site. BY LOGGING INTO THE SITE, YOU ARE BEING COMPLIANT THAT THESE TERMS and you represent that you have the authority and capacity to enter into these Terms. YOU SHOULD BE AT LEAST 18 YEARS OF AGE TO ACCESS THE SITE. IF YOU DISAGREE WITH ALL OF THE PROVISION OF THESE TERMS, DO NOT LOG INTO AND/OR USE THE SITE."),
                  SizedBox(height:10),
                  Text("These terms require the use of arbitration Section 10.2 on an individual basis to resolve disputes and also limit the remedies available to you in the event of a dispute. These Terms of Use were created with the help of the Terms Of Use Generator and the Privacy Policy Generator."),
                  SizedBox(height:10),
                  Text("Access to the Site",style: TextStyle(fontSize:16),),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Subject to these Terms. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "Company grants you a non-transferable, non-exclusive, revocable, limited license to access the Site solely for your own personal, noncommercial use.",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Certain Restrictions. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "The rights approved to you in these Terms are subject to the following restrictions: (a) you shall not sell, rent, lease, transfer, assign, distribute, host, or otherwise commercially exploit the Site; (b) you shall not change, make derivative works of, disassemble, reverse compile or reverse engineer any part of the Site; (c) you shall not access the Site in order to build a similar or competitive website; and (d) except as expressly stated herein, no ",
                        ),
                        new TextSpan(
                          text: "part of the Site may be copied, reproduced, distributed, republished, downloaded, displayed, posted or transmitted in any form or by any means unless otherwise indicated, any future release, update, or other addition to functionality of the Site shall be subject to these Terms.  All copyright and other proprietary notices on the Site must be retained on all copies thereof. ",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("Company reserves the right to change, suspend, or cease the Site with or without notice to you.  You approved that Company will not be held liable to you or any third-party for any change, interruption, or termination of the Site or any part."),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "No Support or Maintenance. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "You agree that Company will have no obligation to provide you with any support in connection with the Site.",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("Excluding any User Content that you may provide, you are aware that all the intellectual property rights, including copyrights, patents, trademarks, and trade secrets, in the Site and its content are owned by Company or Company’s suppliers. Note that these Terms and access to the Site do not give you any rights, title or interest in or to any intellectual property rights, except for the limited access rights expressed in Section 2.1. Company and its suppliers reserve all rights not granted in these Terms."),
                  SizedBox(height:10),
                  Text("User Content",style: TextStyle(fontSize:16),),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "User Content. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "'User Content' means any and all information and content that a user submits to the Site. You are exclusively responsible for your User Content. You bear all risks associated with use of your User Content.  You hereby certify that your User Content does not violate our Acceptable Use Policy.  You may not represent or imply to others that your User Content is in any way provided, sponsored or endorsed by Company. Because you alone are responsible for your User Content, you may expose yourself to liability. Company is not obliged to backup any User Content that you post; also, your User Content may be deleted at any time without prior notice to you. You are solely responsible for making your own backup copies of your User Content if you desire.",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("You hereby grant to Company an irreversible, nonexclusive, royalty-free and fully paid, worldwide license to reproduce, distribute, publicly display and perform, prepare derivative works of, incorporate into other works, and otherwise use and exploit your User Content, and to grant sublicenses of the foregoing rights, solely for the purposes of including your User Content in the Site.  You hereby irreversibly waive any claims and assertions of moral rights or attribution with respect to your User Content."),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Acceptable Use Policy. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "The following terms constitute our 'Acceptable Use Policy': You agree not to use the Site to collect, upload, transmit, display, or distribute any User Content (i) that violates any third-party right or any intellectual property or proprietary right; (ii) that is unlawful, harassing, abusive, tortious, threatening, harmful, invasive of another’s privacy, vulgar, defamatory, false, intentionally misleading, trade libelous, pornographic, obscene, patently offensive, promotes racism, bigotry, hatred, or physical harm of any kind against any group or individual; (iii) that is harmful to minors in any way; or (iv) that is in violation of any law, regulation, or obligations or restrictions imposed by any third party.",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("In addition, you agree not to: (i) upload, transmit, or distribute to or through the Site any software intended to damage or alter a computer system or data; (ii) send through the Site unsolicited or unauthorized advertising, promotional materials, junk mail, spam, chain letters, pyramid schemes, or any other form of duplicative or unsolicited messages; (iii) use the Site to harvest, collect, gather or assemble information or data regarding other users without their consent; (iv) interfere with, disrupt, or create an undue burden on servers or networks connected to the Site, or violate the regulations, policies or procedures of such networks; (v) attempt to gain unauthorized access to the Site, whether through password mining or any other means; (vi) harass or interfere with any other user’s use and enjoyment of the Site; or (vi) use software or automated agents or scripts to produce multiple accounts on the Site, or to generate automated searches, requests, or queries to the Site."),
                  SizedBox(height:10),
                  Text("We reserve the right to review any User Content, and to investigate and/or take appropriate action against you in our sole discretion if you violate the Acceptable Use Policy or any other provision of these Terms or otherwise create liability for us or any other person. Such action may include removing or modifying your User Content, terminating your Account in accordance with Section 8, and/or reporting you to law enforcement authorities."),
                  SizedBox(height:10),
                  Text("If you provide Company with any feedback or suggestions regarding the Site, you hereby assign to Company all rights in such Feedback and agree that Company shall have the right to use and fully exploit such Feedback and related information in any manner it believes appropriate.  Company will treat any Feedback you provide to Company as non-confidential and non-proprietary."),
                  SizedBox(height:10),
                  Text("You agree to indemnify and hold Company and its officers, employees, and agents harmless, including costs and attorneys’ fees, from any claim or demand made by any third-party due to or arising out of (a) your use of the Site, (b) your violation of these Terms, (c) your violation of applicable laws or regulations or (d) your User Content.  Company reserves the right to assume the exclusive defense and control of any matter for which you are required to indemnify us, and you agree to cooperate with our defense of these claims.  You agree not to settle any matter without the prior written consent of Company.  Company will use reasonable efforts to notify you of any such claim, action or proceeding upon becoming aware of it."),
                  SizedBox(height:10),
                  Text("Third-Party Links & Ads; Other Users",style:TextStyle(fontSize: 16)),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Third-Party Links & Ads. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "The Site may contain links to third-party websites and services, and/or display advertisements for third-parties.  Such Third-Party Links & Ads are not under the control of Company, and Company is not responsible for any Third-Party Links & Ads.  Company provides access to these Third-Party Links & Ads only as a convenience to you, and does not review, approve, monitor, endorse, warrant, or make any representations with respect to Third-Party Links & Ads.  You use all Third-Party Links & Ads at your own risk, and should apply a suitable level of caution and discretion in doing so. When you click on any of the Third-Party Links & Ads, the applicable third party’s terms and policies apply, including the third party’s privacy and data gathering practices.",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Other Users. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "Each Site user is solely responsible for any and all of its own User Content.  Because we do not control User Content, you acknowledge and agree that we are not responsible for any User Content, whether provided by you or by others.  You agree that Company will not be responsible for any loss or damage incurred as the result of any such interactions.  If there is a dispute between you and any Site user, we are under no obligation to become involved.",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("You hereby release and forever discharge the Company and our officers, employees, agents, successors, and assigns from, and hereby waive and relinquish, each and every past, present and future dispute, claim, controversy, demand, right, obligation, liability, action and cause of action of every kind and nature, that has arisen or arises directly or indirectly out of, or that relates directly or indirectly to, the Site. If you are a California resident, you hereby waive California civil code section 1542 in connection with the foregoing, which states: 'a general release does not extend to claims which the creditor does not know or suspect to exist in his or her favor at the time of executing the release, which if known by him or her must have materially affected his or her settlement with the debtor.'"),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Cookies and Web Beacons. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "Like any other website, Little Cake Story uses ‘cookies’. These cookies are used to store information including visitors’ preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users’ experience by customizing our web page content based on visitors’ browser type and/or other information. ",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Google DoubleClick DART Cookie.  ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "Google is one of a third-party vendor on our site. It also uses cookies, known as DART cookies, to serve ads to our site visitors based upon their visit to www.website.com and other sites on the internet. However, visitors may choose to decline the use of DART cookies by visiting the Google ad and content network Privacy Policy at the following URL –  ",
                        ),
                        new TextSpan(
                          text: "https://policies.google.com/technologies/ads ",style:TextStyle(color:Colors.blue[200])
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("Disclaimers",style:TextStyle(fontSize: 16)),
                  SizedBox(height:10),
                  Text("The site is provided on an 'as-is' and 'as available' basis, and company and our suppliers expressly disclaim any and all warranties and conditions of any kind, whether express, implied, or statutory, including all warranties or conditions of merchantability, fitness for a particular purpose, title, quiet enjoyment, accuracy, or non-infringement.  We and our suppliers make not guarantee that the site will meet your requirements, will be available on an uninterrupted, timely, secure, or error-free basis, or will be accurate, reliable, free of viruses or other harmful code, complete, legal, or safe.  If applicable law requires any warranties with respect to the site, all such warranties are limited in duration to ninety (90) days from the date of first use."),
                  SizedBox(height:10),
                  Text("Some jurisdictions do not allow the exclusion of implied warranties, so the above exclusion may not apply to you.  Some jurisdictions do not allow limitations on how long an implied warranty lasts, so the above limitation may not apply to you."),
                  SizedBox(height:10),
                  Text("Limitation on Liability",style:TextStyle(fontSize: 16)),
                  SizedBox(height:10),
                  Text("To the maximum extent permitted by law, in no event shall company or our suppliers be liable to you or any third-party for any lost profits, lost data, costs of procurement of substitute products, or any indirect, consequential, exemplary, incidental, special or punitive damages arising from or relating to these terms or your use of, or incapability to use the site even if company has been advised of the possibility of such damages.  Access to and use of the site is at your own discretion and risk, and you will be solely responsible for any damage to your device or computer system, or loss of data resulting therefrom."),
                  SizedBox(height:10),
                  Text("To the maximum extent permitted by law, notwithstanding anything to the contrary contained herein, our liability to you for any damages arising from or related to this agreement, will at all times be limited to a maximum of fifty U.S. dollars (u.s. 50). The existence of more than one claim will not enlarge this limit.  You agree that our suppliers will have no liability of any kind arising from or relating to this agreement."),
                  SizedBox(height:10),
                  Text("Some jurisdictions do not allow the limitation or exclusion of liability for incidental or consequential damages, so the above limitation or exclusion may not apply to you."),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Term and Termination. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text: "Subject to this Section, these Terms will remain in full force and effect while you use the Site.  We may suspend or terminate your rights to use the Site at any time for any reason at our sole discretion, including for any use of the Site in violation of these Terms.  Upon termination of your rights under these Terms, your Account and right to access and use the Site will terminate immediately.  You understand that any termination of your Account may involve deletion of your User Content associated with your Account from our live databases.  Company will not have any liability whatsoever to you for any termination of your rights under these Terms.  Even after your rights under these Terms are terminated, the following provisions of these Terms will remain in effect: Sections 2 through 2.5, Section 3 and Sections 4 through 10. ",
                        ),
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("Copyright Policy.",style:TextStyle(fontSize: 16)),
                  SizedBox(height:10),
                  Text("Company respects the intellectual property of others and asks that users of our Site do the same.  In connection with our Site, we have adopted and implemented a policy respecting copyright law that provides for the removal of any infringing materials and for the termination of users of our online Site who are repeated infringers of intellectual property rights, including copyrights.  If you believe that one of our users is, through the use of our Site, unlawfully infringing the copyright(s) in a work, and wish to have the allegedly infringing material removed, the following information in the form of a written notification (pursuant to 17 U.S.C. § 512(c)) must be provided to our designated Copyright Agent:"),
                  SizedBox(height:10),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("• your physical or electronic signature;"),
                        Text("• identification of the copyrighted work(s) that you claim to have been infringed;"),
                        Text("• identification of the material on our services that you claim is infringing and that you request us to remove;"),
                        Text("• sufficient information to permit us to locate such material;"),
                        Text("• your address, telephone number, and e-mail address;"),
                        Text("• a statement that you have a good faith belief that use of the objectionable material is not authorized by the copyright owner, its agent, or under the law; and"),
                        Text("• a statement that the information in the notification is accurate, and under penalty of perjury, that you are either the owner of the copyright that has allegedly been infringed or that you are authorized to act on behalf of the copyright owner."),
                      ]
                    ),
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Entire Terms.",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text:"These Terms constitute the entire agreement between you and us regarding the use of the Site. Our failure to exercise or enforce any right or provision of these Terms shall not operate as a waiver of such right or provision. The section titles in these Terms are for convenience only and have no legal or contractual effect. The word 'including' means 'including without limitation'. If any provision of these Terms is held to be invalid or unenforceable, the other provisions of these Terms will be unimpaired and the invalid or unenforceable provision will be deemed modified so that it is valid and enforceable to the maximum extent permitted by law.  Your relationship to Company is that of an independent contractor, and neither party is an agent or partner of the other.  These Terms, and your rights and obligations herein, may not be assigned, subcontracted, delegated, or otherwise transferred by you without Company’s prior written consent, and any attempted assignment, subcontract, delegation, or transfer in violation of the foregoing will be null and void.  Company may freely assign these Terms.  The terms and conditions set forth in these Terms shall be binding upon assignees.",
                        )
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Your Privacy. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text:"Please read our Privacy Policy.",
                        )
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  text = new RichText(
                    text : new TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        new TextSpan(
                          text: "Copyright/Trademark Information. ",
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        new TextSpan(
                          text:"Copyright ©. All rights reserved.  All trademarks, logos and service marks displayed on the Site are our property or the property of other third-parties. You are not permitted to use these Marks without our prior written consent or the consent of such third party which may own the Marks.",
                        )
                      ]
                    )
                  ),
                  SizedBox(height:10),
                  Text("Contact Information",style:TextStyle(fontSize: 16)),
                  SizedBox(height:10),
                  Text("Address: Sintok"),
                  SizedBox(height:10),
                  Text("Email: shenmeng0124@gmail.com",style:TextStyle(fontSize: 16)),
                ]
              ),
            )
          ]
        ),
      ),
    );
  }
}