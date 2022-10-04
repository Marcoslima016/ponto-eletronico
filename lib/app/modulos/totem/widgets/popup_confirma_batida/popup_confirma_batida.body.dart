import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupConfirmaBatidaBody extends StatefulWidget {
  String dthr;
  String nome;

  PopupConfirmaBatidaBody({
    @required this.dthr,
    @required this.nome,
  });

  @override
  State<PopupConfirmaBatidaBody> createState() => _PopupConfirmaBatidaBodyState();
}

class _PopupConfirmaBatidaBodyState extends State<PopupConfirmaBatidaBody> with TickerProviderStateMixin {
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  initState() {
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    Future.delayed(const Duration(milliseconds: 500), () {
      animation.forward();
    });

    Future.delayed(const Duration(milliseconds: 3150), () {
      animation.reverse();
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / 100;
    double w = MediaQuery.of(context).size.width / 100;
    return FadeTransition(
      opacity: animation,
      child: Container(
        width: w * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //----------- POPUP WINDOW STYLE ----------
              width: w * 90,
              height: h * 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFF01579B),
                // color: Colors.green,
              ),
              padding: EdgeInsets.only(left: w * 6, right: w * 6),
              //-----------------------------------------
              child: Padding(
                padding: EdgeInsets.only(top: h * 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //[------------------------------------------ CONTEUDO POPUP ------------------------------------------]

                    ///------------- BOTAO FECHAR POPUP -------------

                    // blocked
                    //     ? Container(
                    //         height: 40,
                    //       )
                    //     : Container(
                    //         width: w * 100,
                    //         height: 40,
                    //         child: Row(
                    //           children: [
                    //             Padding(
                    //               padding: EdgeInsets.only(left: w * 4, top: w * 4),
                    //               child: GestureDetector(
                    //                 onTap: () {
                    //                   Navigator.pop(Get.context);
                    //                 },
                    //                 child: Icon(
                    //                   Icons.close,
                    //                   color: Colors.grey[300],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),

                    //----------------------------------------------------

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: h * 2.5,
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.grey[350],
                          size: h * 13,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: h * 5, left: w * 6, right: w * 6),
                          child: Text(
                            "PONTO REGISTRADO COM SUCESSO",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26.sp,
                              height: 1.4,
                              color: Colors.white,
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: h * 5),
                          child: Text(
                            widget.dthr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.grey[350],
                              fontFamily: "Open Sans",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: h * 10),
                          child: Text(
                            widget.nome,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //
                    //[----------------------------------------------------------------------------------------------------]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
