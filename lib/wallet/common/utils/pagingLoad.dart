import 'package:mars/wallet/common/component_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PagingLoad {
  //页数
  int currPage = 0;

  //总数
  int pageSize = 10;

  //true加载完成 false正在加载
  bool loading = false;

  //true有数据 false无数据
  bool errorNullData = true;

  //判断当前是否第一页
  bool _isCurrPage() {
    return currPage == 1;
  }

  //重置
  _reset() {
    currPage = 0;
  }

  //回滚上一页请求
  _reduce() {
    if (currPage <= 1) {
      currPage = 0;
    } else
      currPage--;
  }

  //下一页
  _add() {
    currPage++;
  }

  setPageSize(size) {
    pageSize = size;
  }

  //请求网络
  request({
    String url, //请求接口
    Map<String, dynamic> params, //参数
    isFirstPage = false, //是否从第一页开始
    Function firstPage, //第一页数据
    Function firstPageNullData, //第一页无数据
    Function nextPage, //下一页数据
    Function nextPageNullData, //下一页无数据
    Function failure, //请求失败
    RefreshController refreshController, //上啦下啦的组件，做状态处理
    currPageName = 'currPage', //当前页字段名
    pageSizeName = 'pageSize', //一页数量字段名
    hierarchy, //获取结构下的list数据
    setState, //当前界面State自动刷一下遍界面
    mounted = true, //app是否是打开状态
  }) {
    loading = false;
    //重置到第一页
    if (isFirstPage) {
      if (refreshController != null) refreshController.loadComplete();
      _reset();
    }
    _add();

    if (params == null) {
      params = new Map();
      params[currPageName] = currPage.toString();
      params[pageSizeName] = pageSize.toString();
    } else {
      params[currPageName] = currPage.toString();
      params[pageSizeName] = pageSize.toString();
    }

    Net().post(url, params, success: (data) {
      errorNullData = true;
      loading = true;
      if (data == null) {
        errorNullData = false;
        if (firstPageNullData != null) firstPageNullData();
        _reduce();
      } else if (hierarchy != null) {
        if (_isCurrPage() && data[hierarchy].length == 0) {
          errorNullData = false;
          _reduce();
          if (firstPageNullData != null) firstPageNullData();
          if (refreshController != null) refreshController.refreshCompleted();
          if (refreshController != null) refreshController.loadNoData();
        } else if (_isCurrPage()) {
          if (firstPage != null) firstPage(data[hierarchy]);
          if (refreshController != null) refreshController.refreshCompleted();
        } else if (data[hierarchy].length == 0) {
          if (nextPageNullData != null) nextPageNullData();
          if (refreshController != null) refreshController.loadNoData();
        } else {
          if (nextPage != null) nextPage(data[hierarchy]);
          if (refreshController != null) refreshController.loadComplete();
        }
      } else {
        if (_isCurrPage() && data.length == 0) {
          errorNullData = false;
          _reduce();
          if (firstPageNullData != null) firstPageNullData();
          if (refreshController != null) refreshController.loadNoData();
          if (refreshController != null) refreshController.refreshCompleted();
        } else if (_isCurrPage()) {
          if (firstPage != null) firstPage(data);
          if (refreshController != null) refreshController.refreshCompleted();
        } else if (data.length == 0) {
          if (nextPageNullData != null) nextPageNullData();
          if (refreshController != null) refreshController.loadNoData();
        } else {
          if (nextPage != null) nextPage(data);
          if (refreshController != null) refreshController.loadComplete();
        }
      }

      if (setState != null && mounted) setState(() {});
    }, failure: (error) {
      errorNullData = false;
      loading = true;
      _reduce();
      if (refreshController != null) refreshController.refreshCompleted();
      if (refreshController != null) refreshController.loadComplete();
      if (refreshController != null) refreshController.loadFailed();
      if (failure != null) failure(error);

      if (setState != null && mounted) setState(() {});
    });
  }
}
