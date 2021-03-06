import 'package:demo7_pro/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo7_pro/widgets/common/img_upload.dart' show ImgUpload;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:demo7_pro/config/theme.dart' show AppTheme;
import 'package:logger/logger.dart';
import 'package:demo7_pro/widgets/common/img_preview.dart' show ImgPreview;
import 'package:demo7_pro/route/route_util.dart' show pushWidget;

class ImgUploadDecorator extends StatefulWidget {
  final int maxLength;
  final List<String> initImgList;
  final Function(List<String> imgUrlList) imgListUploadCallback;
  final bool readOnly;

  ImgUploadDecorator(
      {Key key,
      this.maxLength = 9,
      this.initImgList,
      this.imgListUploadCallback,
      this.readOnly})
      : super(key: key);

  @override
  _ImgUploadDecoratorState createState() => _ImgUploadDecoratorState();
}

class _ImgUploadDecoratorState extends State<ImgUploadDecorator> {
  List<String> imgList = [];

  @override
  void initState() {
    setState(() {
      this.imgList = widget.initImgList ?? [];
    });
    super.initState();
  }

  @override
  didUpdateWidget(ImgUploadDecorator oldWidget) {

    this.imgList = widget.initImgList ?? [];
    print('查看图片上传${this.imgList}');
    super.didUpdateWidget(oldWidget);
  }

  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.47, // 宽高比
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: showGridBlock.length,
          itemBuilder: (BuildContext context, int index) {
            return showGridBlock[index] == 'add'
                ? widget.readOnly
                    ? Container()
                    : _addNewImg()
                : _ImgGridItem(showGridBlock[index], index);
          }),
    );
  }

  Widget _ImgGridItem(String url, int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              width: 1, color: AppTheme.borderColor.withOpacity(0.7)),
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            child: Image.network(
              url,
              fit: BoxFit.fill,
            ),
            onTap: () {
              _openImgPreview(index, imgList);
            },
          ),
          Positioned(
              top: 5,
              right: 5,
              child: widget.readOnly
                  ? Container()
                  : GestureDetector(
                      child: Icon(
                        Icons.delete_forever,
                        color: AppTheme.sitDangerColor,
                      ),
                      onTap: () {
                        _deleteImg(index);
                      },
                    ))
        ],
      ),
    );
  }

  void _openImgPreview(int imgIndex, List<String> imgList) {
    pushWidget(
      context,
      ImgPreview(
        images: imgList,
        initIndex: imgIndex,
      ),
    );
  }

  void _deleteImg(index) {
    if (index < imgList.length) {
      setState(() {
        imgList.removeAt(index);
      });
    }
    if (widget.imgListUploadCallback != null) {
      widget.imgListUploadCallback.call(this.imgList); // 上传成功后把页面显示的imgUrl全部返回
    }
  }

  List<String> get showGridBlock {
    List<String> imgShowArr = [];
    if (this.imgList != null) {
      imgShowArr.addAll(this.imgList);
      if (widget.maxLength > 0 && this.imgList.length < widget.maxLength) {
        imgShowArr.add('add'); // 如果最大限制存在，且当前渲染项小于最大限制
      }
    }
    if (widget.maxLength < 0 || widget.maxLength == null) {
      imgShowArr.add('add'); // 最大限制不存在，恒定显示
    }

    return imgShowArr;
  }

  int get pickerMaxLength {
    int maxNumb = widget.maxLength - this.imgList.length;
    if (maxNumb <= 0) {
      maxNumb = 1;
    }
    return maxNumb;
  }

  Widget _addNewImg() {
    return ImgUpload(
        maxLength: pickerMaxLength,
        isMulti: true,
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_a_photo,
                color: AppTheme.placeholderColor,
              ),
              Padding(padding: EdgeInsets.only(top: 16)),
              Text(
                '营业执照副本',
                style: TextStyle(color: AppTheme.placeholderColor),
              )
            ],
          ),
        ),
        onSuccessFn: _onSuccessFn,
        onChangeFn: _onChange);
  }

  void _onSuccessFn(List<String> urlList) {
    // 返回上传成功后的图片
    setState(() {
      this.imgList.addAll(urlList);
    });
    if (widget.imgListUploadCallback != null) {
      widget.imgListUploadCallback.call(this.imgList); // 上传成功后把页面显示的imgUrl全部返回
    }
  }

  void _onChange(List<dynamic> filesList) {} // 返回的文件列表
}
