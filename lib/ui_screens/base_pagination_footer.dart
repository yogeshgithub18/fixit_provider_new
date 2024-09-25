import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class BasePaginationFooter extends StatelessWidget {
  const BasePaginationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context,LoadStatus? mode){
        Widget body ;
        if(mode==LoadStatus.idle){
          body =  const Text("Pull up load",style: TextStyle(color: Colors.grey, fontSize: 12));
        }
        else if(mode==LoadStatus.loading){
          body =  const CupertinoActivityIndicator();
        }
        else if(mode == LoadStatus.failed){
          body = const Text("Load failed",style: TextStyle(color: Colors.grey, fontSize: 12));
        }
        else if(mode == LoadStatus.canLoading){
          body = const Text("Release to load more",style: TextStyle(color: Colors.grey, fontSize: 12));
        }
        else{
          body = const Text("No more data",style: TextStyle(color: Colors.grey, fontSize: 12));
        }
        return SizedBox(
          height: 55.0,
          child: Center(child:body),
        );
      },
    );
  }
}

