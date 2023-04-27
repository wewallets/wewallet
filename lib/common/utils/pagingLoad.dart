class PagingLoad {
  //页数
  int currPage = 0;

  //总数
  int pageSize = 20;

  //true正在加载 false显示数据
  bool loading = true;

  //判断当前是否第一页
  bool isCurrPage() {
    return currPage == 1;
  }

  //重置
  reset() {
    loading = true;
    currPage = 0;
  }

  //回滚上一页请求
  reduce() {
    if (currPage <= 1) {
      currPage = 0;
    } else
      currPage--;
  }

  //返回分页参数map
  Map<String, String> getMapPagingLoad() {
    currPage++;
    Map<String, String> _map = new Map();
    _map["currPage"] = currPage.toString();
    _map["pageSize"] = pageSize.toString();
    return _map;
  }
}
