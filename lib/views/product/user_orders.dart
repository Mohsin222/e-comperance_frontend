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

class _UserOrdersState extends ConsumerState<UserOrders> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
         
           WidgetsBinding.instance.addPostFrameCallback((_)async{
            final userprov =ref.watch(userProvider);
 await    ref.watch(orderControllerProvider.notifier).getUserOrders(context, userprov!.sId);
  });
  }
  
  @override
  Widget build(BuildContext context) {
    final userOrdProv =ref.watch(userOrderListProvider);
    final orderControllerProv=ref.watch(orderControllerProvider);
    print(orderControllerProv);
    return Scaffold(
// appBar: AppBar(
//   title: Text('User Orders'),
// ),
      body:SizedBox(
        height: 1.sh,
        child: Column(children:[  
          CustomPrimaryHeaderContainer(
            child: Column(
              children: [
                      CustomAppBar(
                  showBackArrow: true,
                  title: Text('User Orders'),
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          ),
          
          orderControllerProv==false ? Expanded(
          // height: 1.sh,
          child: ListView.builder(
            itemCount: userOrdProv.length,
            itemBuilder: (context,index){
        
        
              if(userOrdProv.length <=0){
                return Center(child: Text('NO Orders'),);
              }
             return Container(
           padding: const EdgeInsets.all(10),
           
          //  return ListTile(
          //    leading: CircleAvatar(backgroundImage: NetworkImage(userOrdProv[index]!.orderItems![ind].productModel!.image.toString())),
          //       title: Text(userOrdProv[index]!.orderItems![ind].productModel!.name.toString()),
          //       subtitle: Text(userOrdProv[index]!.country.toString()),
          //     );
         child:   Card(
        
          clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [    
             
                         mainRowsWidget(title:'Status',body: userOrdProv[index]!.status.toString()) ,   
                                 mainRowsWidget(title:'OrderId',body:userOrdProv[index]!.sId.toString()) ,   
                   SizedBox(
                         height: userOrdProv[index]!.orderItems!.length * 100.h,
                     child: ListView.builder(
                    physics:const NeverScrollableScrollPhysics(),
                         itemCount: userOrdProv[index]!.orderItems!.length,
                      itemBuilder: (context,ind){
          
                      return Card(
                                // color: Colors.purpleAccent,
                                         color: Colors.grey,
                        child: Row(
                          children: [
                           Container(
                      
                                 height: 70.h,
                    width: 0.3.sw,
                    decoration: BoxDecoration(
                                         color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(image: NetworkImage(userOrdProv[index]!.orderItems![ind].productModel!.image??'https://images.unsplash.com/photo-1609709295948-17d77cb2a69b?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Y2xvdGhzfGVufDB8fDB8fHww'),fit: BoxFit.cover)),
                           ) ,
                                SizedBox(width: 5.w,),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text(userOrdProv[index]!.orderItems![ind].productModel!.name ?? '',
                                       style: TextStyle(
                                              fontWeight: FontWeight.w300,
        
           fontSize: 12.sp
                                        ),
                                  ),
                         Text(userOrdProv[index]!.orderItems![ind].productModel!.price.toString(),
                              style: TextStyle(
                                              fontWeight: FontWeight.w100,
        
        
           fontSize: 12.sp
                                        ),
                         ),
                                        Text(userOrdProv[index]!.orderItems![ind].productModel!.description.toString(),
                                        style: TextStyle(
                                              fontWeight: FontWeight.w100,
        
           fontSize: 12.sp
                                        ),
                                        ),
                                ],))
                          ],
                        ),
                      );
                     }),
                   ),
              
              
        mainRowsWidget(title:'Address1',body: userOrdProv[index]!.shippingAddress1.toString()) ,      
        mainRowsWidget(title:'Address2',body: userOrdProv[index]!.shippingAddress2.toString()),
        mainRowsWidget(title:'Total Price',body: userOrdProv[index]!.totalPrice.toString()),
              mainRowsWidget(title:'Created Date',body: userOrdProv[index]!.dateordered.toString() )
                  ],
                ),
              ),
            )
          
             );
          }),
        ):Center(child: Text('NO DATA'),),
        ]),
      )
    );
  }

  mainRowsWidget(
   {String? title ,String? body}
  ){
    return Row(     mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Flexible(
      child: Text(title!,
           style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
          fontSize: 15.sp
        ),
      ),
    ),Flexible(
      child: Text(body!,
      
      style: TextStyle(
         fontWeight: FontWeight.w300,
        overflow: TextOverflow.ellipsis,
         fontSize: 12.sp
      ),
      ),
    ),],);
  }
}