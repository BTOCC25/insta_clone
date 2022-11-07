import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/src/components/image_data.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  var albumns = <AssetPathEntity>[];
  var headerTitle = '';
  var imageList = <AssetEntity>[];

  AssetEntity? selectedImage;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async{
    var result = await PhotoManager.requestPermissionExtend(); // permission을 가져온다.
    if (result.isAuth){ // 권한이 있을때
      albumns = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minWidth: 100, minHeight: 100), // 이미지 사이즈
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false) // 생성 최근일자로
          ],
        ),
      );
      _loadData();
    }else{
      // message 권한 요청
    }
  }

  void _loadData() async{
    headerTitle = albumns.first.name;

    await _pagingPhotos(); // 이미지 페이징

    update();
  }

  Future<void> _pagingPhotos() async{
    var photos = await albumns.first.getAssetListPaged(
        page: 0, // 페이지
        size: 30 // 총 몇장을 가져올거냐
    );
    imageList.addAll(photos);
    selectedImage = imageList.first;
  }

  void update() => setState(() {
  });

  Widget _imagePreview(){
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width,
      color: Colors.grey,
      child: selectedImage == null
          ? Container()
          : FutureBuilder(
          future: selectedImage!.thumbnailDataWithSize(ThumbnailSize(width.toInt(), width.toInt())),
          builder: (_, AsyncSnapshot<Uint8List?> snapshot){
            if (snapshot.hasData){
              return Image.memory(snapshot.data!,
                fit: BoxFit.cover,
              );
            }else{
              return Container();
            }
          }
      )
      ,
    );
  }

  Widget _header(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                isScrollControlled: true, // 스크롤이 끝까지 올라간다.
                constraints: BoxConstraints( // safearea 는 보호하는데까지 스크롤
                    maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top
                ),

                builder: (_) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            width: 40,
                            height: 4,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                albumns.length,
                                  (index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 25
                                    ),
                                    child: Text(albumns[index].name),
                                  )
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
                  );
                }
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(headerTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    ImageData(ImagePath.imageSelectIcon),
                    const SizedBox(width: 7),
                    const Text("여러 항목 선택",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(ImagePath.cameraIcon),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList(){
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // 스크롤을 하지 않겟다.
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 몇단계로 쪼갤거냐
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1, // 정사각형의 사이즈
      ),
      itemCount: imageList.length, // 몇개 생성할건지
      itemBuilder: (BuildContext context, int index){
        return _photoWidget(imageList[index]);
      }
    );
  }

  Widget _photoWidget(AssetEntity asset){
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot){
        if (snapshot.hasData){
          return Image.memory(snapshot.data!,
            fit: BoxFit.cover,
          );
        }else{
          return Container();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(ImagePath.closeImage),
          ),
        ),
        title: const Text("New Post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(ImagePath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }
}
