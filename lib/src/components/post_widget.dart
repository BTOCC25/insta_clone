import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/src/components/avatar_widget.dart';
import 'package:instagram_clone_coding/src/components/image_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  Widget _header(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AvatarWidget(
            type: AvatarType.TYPE3,
            thumbPath: "https://static.remove.bg/remove-bg-web/ea3c274e1b7f6fbbfe93fad8b2b13d7ef352f09c/assets/start-1abfb4fe2980eabfbbaaa4365a0692539f7cd2725f324f904565a9a744f8e214.jpg",
            nickname: "박동훈",
            size: 40,
          ),
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                ImagePath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image(){
    return CachedNetworkImage(
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png",
    );
  }

  Widget _infoCount(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(
                ImagePath.likeOffIcon,
                width: 65,
              ),
              const SizedBox(width: 15),
              ImageData(
                ImagePath.replyIcon,
                width: 60,
              ),
              const SizedBox(width: 15),
              ImageData(
                ImagePath.directMessage,
                width: 55,
              )
            ],
          ),
          ImageData(
            ImagePath.bookMarkOffIcon,
            width: 50,
          )
        ],
      ),
    );
  }

  Widget _infoDescription(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "좋아요 150개",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            "콘텐츠1입니다.\n콘텐츠1입니다.\n콘텐츠1입니다.\n콘텐츠1입니다.\n",
            prefixText: "박동훈",
            onPrefixTap: (){
              print("박동훈 페이지 이동");
            },
            prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
            expandText: "더보기",
            collapseText: "접기",
            maxLines: 3,
            expandOnTextTap: true, // 더보기 아닌 텍스트 터치시 펼쳐짐
            collapseOnTextTap: true,
            linkColor: Colors.grey, // 더 보기 색깔
          ),
        ],
      ),
    );
  }

  Widget _replyTextBtn(){
    return GestureDetector(
      onTap: (){},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "댓글 159개 모두 보기",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13
          ),
        ),
      ),
    );
  }

  Widget _dateAgo(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "1일 전",
        style: TextStyle(
            color:Colors.grey,
            fontSize: 11),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(height: 15,),
          _image(),
          const SizedBox(height: 15,),
          _infoCount(),
          const SizedBox(height: 5,),
          _infoDescription(),
          const SizedBox(height: 5,),
          _replyTextBtn(),
          const SizedBox(height: 5,),
          _dateAgo(),
        ],
      ),
    );
  }
}
