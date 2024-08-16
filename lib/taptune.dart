library taptune;
import 'dart:convert';
import 'package:http/http.dart' as http;

class TapTuneSDK {
  late String appID;
  late List<KnowledgeBase> knowledgeBase;
  late Function callback;
  late ApiClient apiClient;

  Future<bool> init({
    required String appID,
    required List<KnowledgeBase> knowledgeBase,
    required Function callback,
  }) async {
    this.appID = appID;
    this.knowledgeBase = knowledgeBase;
    this.callback = callback;

    apiClient = ApiClient();
    return await updateKnowledgeBase(knowledgeBase);
  }

  Future<bool> updateKnowledgeBase(List<KnowledgeBase> content, {String? appID}) async {
    try {
      // TODO: 创建或更新工作流知识库
      return true;
    } catch (error) {
      return false;
    }
  }


  Future<Map<String, dynamic>> callWorkflow(String query, {bool auto = false, String? appID}) async {
    try {
      final response = await apiClient.runWorkflow(query: query, appID: appID ?? this.appID);

      // 如果请求成功
      if (response['status'] == 'succeeded') {
        // 获取并处理 param 字段，去除中括号
        String param = response['outputs']['param'];
        if (param.startsWith('[') && param.endsWith(']')) {
          param = param.substring(1, param.length - 1); // 去除首尾的中括号
          // 将字符串拆分为列表
          List<String> parts = param.split(',');
          // 去除每个元素的首尾空格并获取最后一个元素
          param = parts.last.trim();
        }
        final result = {
          'id': response['outputs']['id'],
          'param': param,
          'name': response['outputs']['name'],
          'desc': response['outputs']['desc'],
        };

        if (auto) {
          callback(result);
        }

        return result;
      } else {
        throw Exception('Workflow did not succeed: ${response['status']}');
      }
    } catch (error) {
      print(error);
      return {
        'id': appID ?? this.appID,
      };
    }
  }
}

class KnowledgeBase {
  final String id;
  final String name;
  final List<Params> params;
  final String desc;

  KnowledgeBase({
    required this.id,
    required this.name,
    required this.params,
    required this.desc,
  });
}

class Params {
  final String name;
  final String desc;

  Params({
    required this.name,
    required this.desc,
  });
}

class ApiClient {

  ApiClient();

  Future<Map<String, dynamic>> getDatasets() async {
    final url = Uri.parse('http://123.249.92.54:5700/v1/datasets?page=1&limit=20');
    final response = await http.get(
      url,
      headers: {},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch cloud content: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> runWorkflow({required String query, required String appID}) async {
    final url = Uri.parse('http://123.249.92.54:5700/v1/workflows/run');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        "inputs": {"query": query, "appid": appID},
        "response_mode": "blocking",
        "user": "taptune"
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to run workflow: ${response.statusCode}');
    }
  }
}