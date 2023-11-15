import 'package:e_comperce_app/controller/aurh_controller.dart';
import 'package:e_comperce_app/models/user_model.dart';
import 'package:e_comperce_app/utils/text_field_decoration.dart';
import 'package:e_comperce_app/views/settings/profile/widget/profile_menu_tile.dart';
import 'package:e_comperce_app/views/settings/settings_screen.dart';
import 'package:e_comperce_app/views/widgets/appbar/custom_appbar.dart';
import 'package:e_comperce_app/views/widgets/custm_primary_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  TextEditingController nameController =TextEditingController();
    TextEditingController phoneController =TextEditingController();


    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  


  getUserData(){
   UserModel? userModel = ref.watch(userProvider);

   nameController.text =userModel!.name!;
   phoneController.text =userModel.phone!;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserData();
     WidgetsBinding.instance.addPostFrameCallback((_){
    getUserData();
  });
  }


    Future updateUser(WidgetRef ref, UserModel? userModel) async {
    await ref.watch(authControllerProvider.notifier).updateUser(
          context:context,
          userModel :userModel!
 
        );

Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomAppBar()));



  }
  @override
  Widget build(BuildContext context, ) {

    return Scaffold(
       
        body:Container(
   
          child: Column(



            children: [

                CustomPrimaryHeaderContainer(child: Column(
              children: const [

              //  CustomHomeAppbar(), 
              CustomAppBar(
                showBackArrow: true,
                title: Text('Profile'),
              ),
       
              SizedBox(height: 32,),


    
         
              ],
            ),
            
          
            
            ),
               Expanded(
                 child: SingleChildScrollView(
                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Column(
                             children: [
                  SizedBox(
                             width: double.infinity,
                             child: Column(children: [
                  TCircularImage(width: 80,height: 80, image: 'https://images.unsplash.com/photo-1694188119956-e28ffd3cf785?auto=format&fit=crop&q=80&w=1374&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                             TextButton(onPressed: (){}, child: Text('Change Profile Picture',style: TextStyle(color: Colors.black),))
                             
                         
                             
                             ]),
                           ),
                         
                           //details
                           const SizedBox(height: 8,),
                           Divider(),
                           const SizedBox(height: 8,),
                  Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.centerLeft,
                    child: Text('Profile',
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700,color: Colors.black),
                    ),
                  ),
                           const SizedBox(height: 8,),
               
                           // ProfileMenuTile(icon: Icons.arrow_right_alt,title: "Name",value: 'VALUE',)
                   TextField(
                      controller: nameController,
                        decoration: TextFieldDecoration.decoration(
                      helperText: 'Name'
                    ),
                    
                             
                    ),
                        const SizedBox(height: 8,),
                       TextField(
                      controller: phoneController,
                        decoration: TextFieldDecoration.decoration(
                      helperText: 'Phone'
                    ),
                    
                             
                    ),
               
               
                        SizedBox(height: 20.h,),
                  
               
                           Container(
                 padding: const EdgeInsets.all(8.0),
                 width: 1.sw,
                 height: 60.h,
                             child: ElevatedButton(onPressed:  ref.watch(authControllerProvider.notifier).state==false? ()async{
                  UserModel? userModel = ref.watch(userProvider);
               
               
               UserModel userModel1 =UserModel(
                 name: nameController.text.trim(),
                 phone: phoneController.text.trim()
               );
                  userModel!.name= nameController.text.trim();
                  userModel.phone = phoneController.text.trim();
               
               // Navigator.popUntil(context, (route) => false);
               
               await updateUser(ref, userModel);
               
                   
                             }:null, child:ref.watch(authControllerProvider.notifier).state==false ? const Text('SAVE'):CircularProgressIndicator())),
                             ],
                           ),
                         )
                       ),
               ),
            ],
          ),
        )
    );
  }
}



class TCircularImage extends ConsumerWidget {
  final BoxFit? fit;
  final String image;
  final bool isNotNetworkImage;
  final Color? overlayColor;
    final Color? backgroundColor;
    final double width,height,padding;
  const TCircularImage({this.fit=BoxFit.cover,required this.image, this.isNotNetworkImage=true, this.overlayColor, this.backgroundColor, this.width=56, this.height=56, this.padding=5,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Center(
        child: FittedBox(
          child: Image(
              width: width,
              height: height,
              
            fit: fit,
            image:  isNotNetworkImage ? NetworkImage(image):AssetImage(image) as ImageProvider,
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}