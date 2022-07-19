import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

bool isLast = false;


class OnBoardingScreen extends StatelessWidget {

  var boardController = PageController();
  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/onboard_1.png',
        title: 'Marketo',
        body: 'Welcome to Marketo Let\'s Shop!'),
    BoardingModel(
        image: 'assets/images/onboard_2.png',
        title: 'Marketo',
        body: 'Browse Our Offers which lead to 50%!'),
    BoardingModel(
        image: 'assets/images/onboard_3.png',
        title: 'Marketo',
        body: 'You will find everything you want.. Go ahead!'),
  ];



  @override
  Widget build(BuildContext context) {
    void submit()
         {navigateAndFinish(context, LoginScreen());
          // CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
          // {
          //
          // });

  }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('e8e6ef'),elevation: 0,
        actions:
        [
          Container(
            margin: EdgeInsets.only(right: 6),
            child: TextButton(onPressed: submit, child: Text('SKIP',style: TextStyle(fontSize: 15,letterSpacing: 1.4),),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boardingList.length - 1)
                    isLast = true;
                  else
                    isLast = false;
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingList[index]),
                itemCount: boardingList.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController, count: boardingList.length,
                    effect: ExpandingDotsEffect(
                        dotWidth: 8,
                        dotHeight: 8,
                        activeDotColor: Colors.blue,
                        expansionFactor: 3,
                        dotColor: Colors.grey,
                        spacing: 5
                    )),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     submit();
                    }
                    else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 44,
              color: Colors.blue,
                letterSpacing: 3,
                fontStyle: FontStyle.italic
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 15,color: Colors.grey[700],
            ),
          ),
          Expanded(child: Image(image: AssetImage('${model.image}'))),

        ],
      );
}
