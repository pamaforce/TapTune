import 'package:taptune/taptune.dart';

void main() async {
  // 初始化 TapTuneSDK
  final tapTune = TapTuneSDK();

  // 初始化 SDK，传入 appID、知识库和回调函数
  bool initSuccess = await tapTune.init(
    appID: 'appid0001',
    knowledgeBase: [
      KnowledgeBase(
        id: 'c6c7aa5f-066e-aa87-f42a-b230ace2aa5b',
        name: '深色模式',
        params: [
          Params(name: 'false', desc: '代表关闭深色模式'),
          Params(name: 'true', desc: '代表打开深色模式'),
        ],
        desc: '这个设置可以帮助用户打开深色模式，也常被称为夜间模式，可以缓解用户觉得屏幕亮度过高带来的问题。',
      ),
    ],
    callback: (result) {
      print('Callback executed with result: $result');
    },
  );

  // 检查初始化是否成功
  if (initSuccess) {
    print('Initialization successful.');

    // 测试 callWorkflow 方法，auto 为 true，自动执行回调
    var result = await tapTune.callWorkflow('打开深色模式', auto: true);
    print('Result with auto: $result');

    // 测试 callWorkflow 方法，auto 为 false，不自动执行回调
    var resultWithoutAuto = await tapTune.callWorkflow('关闭深色模式');
    print('Result without auto: $resultWithoutAuto');

  } else {
    print('Initialization failed.');
  }
}