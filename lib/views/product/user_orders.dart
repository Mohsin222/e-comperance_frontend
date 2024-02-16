import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/controller/order_controller.dart';
import 'package:e_comperce_app/repositary/order_services/order_service.dart';
import 'package:e_comperce_app/views/widgets/custm_primary_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/appbar/custom_appbar.dart';

class UserOrders extends ConsumerStatefulWidget {
  UserOrders({super.key});

  @override
  ConsumerState<UserOrders> createState() => _UserOrdersState();
}

//When your app state resumes (or wakes your app), trigger the stop   event to the above port listener:
// with WidgetsBindingObserver
//    WidgetsBinding.instance.addObserver(this);
//    WidgetsBinding.instance.removeObserver(this);

class _UserOrdersState extends ConsumerState<UserOrders>
    with WidgetsBindingObserver {
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadInitalData();
    _controller = ScrollController()..addListener(_loadMore);
  }

  late ScrollController _controller;

  loadInitalData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var inialLoadCheck = ref.watch(initalDataLoaded);
      if (inialLoadCheck == false) {
        final userprov = ref.watch(userProvider);
        await ref
            .watch(orderControllerProvider.notifier)
            .getUserOrders(context: context, userId: userprov!.sId, pageNo: 1);
      }
    });
  }

  _loadMore() async {
    if (ref.watch(orderNextPagePaginationValue) == true &&
        ref.watch(orderControllerProvider.notifier).state == false &&
        _controller.position.extentAfter < 1) {
      page++;

      final userprov = ref.watch(userProvider);
      await ref.watch(orderControllerProvider.notifier).loadMoreOrders(
          context: context, userId: userprov!.sId, pageNo: page);

// setState(() {

// });
    }
  }

  Future<void> _pullRefresh() async {
    ref.watch(initalDataLoaded.notifier).state = false;
    ref.watch(orderNextPagePaginationValue.notifier).state = true;
    page = 1;
    await loadInitalData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userOrdProv = ref.watch(userOrderListProvider);
    final orderControllerProv = ref.watch(orderControllerProvider);

    // print(orderControllerProv);
    return Scaffold(
        body: RefreshIndicator(
          
      onRefresh: _pullRefresh,
      child: SizedBox(
        height: 1.sh,
        child: Column(children: [
          CustomPrimaryHeaderContainer(
            child: Column(
              children: [
                const CustomAppBar(
                  showBackArrow: true,
                  title: Text('User Orders'),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),

          orderControllerProv == false
              ? Expanded(
                  flex: 2,
                  // height: 1.sh,
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: userOrdProv.length,
                      itemBuilder: (context, index) {
                        if (userOrdProv.length <= 0) {
                          return Center(
                            child: Text('NO Orders'),
                          );
                        }
                        return Container(
                            padding: const EdgeInsets.all(10),

                            //  return ListTile(
                            //    leading: CircleAvatar(backgroundImage: NetworkImage(userOrdProv[index]!.orderItems![ind].productModel!.image.toString())),
                            //       title: Text(userOrdProv[index]!.orderItems![ind].productModel!.name.toString()),
                            //       subtitle: Text(userOrdProv[index]!.country.toString()),
                            //     );
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    mainRowsWidget(
                                        title: 'Status',
                                        body: userOrdProv[index]!
                                            .status
                                            .toString()),
                                    mainRowsWidget(
                                        title: 'OrderId',
                                        body:
                                            userOrdProv[index]!.sId.toString()),
                                    SizedBox(
                                      height: userOrdProv[index]!
                                              .orderItems!
                                              .length *
                                          100.h,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: userOrdProv[index]!
                                              .orderItems!
                                              .length,
                                          itemBuilder: (context, ind) {
                                            return Card(
                                              
                                              elevation: 0,
                                              // color: Colors.purpleAccent,
                                              // color: Colors.grey,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 70.h,
                                                    width: 0.3.sw,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                        image: DecorationImage(
                                                            image: NetworkImage(userOrdProv[
                                                                        index]!
                                                                    .orderItems![
                                                                        ind]
                                                                    .productModel!
                                                                    .image ??
                                                                'https://images.unsplash.com/photo-1609709295948-17d77cb2a69b?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2xvdGhzfGVufDB8fDB8fHww'),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        userOrdProv[index]!
                                                                .orderItems![
                                                                    ind]
                                                                .productModel!
                                                                .name ??
                                                            '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 12.sp),
                                                      ),
                                                      Text(
                                                        userOrdProv[index]!
                                                            .orderItems![ind]
                                                            .productModel!
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontSize: 12.sp),
                                                      ),
                                                      Text(
                                                        userOrdProv[index]!
                                                            .orderItems![ind]
                                                            .productModel!
                                                            .description
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            fontSize: 12.sp),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            );
                                          }),
                                    ),

                                    // mainRowsWidget(title:'Address1',body: userOrdProv[index]!.shippingAddress1.toString()) ,
                                    // mainRowsWidget(title:'Address2',body: userOrdProv[index]!.shippingAddress2.toString()),
                                    // mainRowsWidget(title:'Total Price',body: userOrdProv[index]!.totalPrice.toString()),
                                    //       mainRowsWidget(title:'Created Date',body: userOrdProv[index]!.dateordered.toString() ),

                                    if (index == userOrdProv.length - 1)
                                      if (ref.watch(
                                              orderNextPagePaginationValue) ==
                                          true)
                                        Container(
                                          height: 80.h,
                                          width: 1.sw,
                                          //  color: Colors.amber,
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 40),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          ),
                                          //       child: const Center(
                                          // child: Text('You have fetched all of the content'))
                                        ),

                                    if (index == userOrdProv.length - 1)
                                      if (ref.watch(
                                              orderNextPagePaginationValue) ==
                                          false)
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          color: Colors.amber,
                                          child: const Center(
                                            child: Text(
                                                'You have fetched all of the content'),
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                )
              : Center(
                  child: Text('NO DATA'),
                ),

          //  if (ref.watch(orderNextPagePaginationValue) == true)
          //                  Container(
          //                   height: 80.h,
          //                   width: 1.sw,
          //                   //  color: Colors.amber,
          //                   padding:const EdgeInsets.only(top: 10, bottom: 40),
          //                   child: Center(
          //                     child: CircularProgressIndicator(color: Colors.black,),
          //                   ),
          //                     //       child: const Center(
          //                     // child: Text('You have fetched all of the content'))
          //                 ),

          //   if (ref.watch(orderNextPagePaginationValue) == false)
          // Container(
          //   padding: const EdgeInsets.only(top: 10, bottom: 10),
          //   color: Colors.amber,
          //   child: const Center(
          //     child: Text('You have fetched all of the content'),
          //   ),
          // ),
        ]),
      ),
    ));
  }

  mainRowsWidget({String? title, String? body}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title!,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp),
          ),
        ),
        Flexible(
          child: Text(
            body!,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                overflow: TextOverflow.ellipsis,
                fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
