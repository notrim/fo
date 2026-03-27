import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';

class QuoteService {
  static const String _lastShownDateKey = 'lastShownDate';
  static const String _todayQuoteIdKey = 'todayQuoteId';
  
  List<Quote> _quotes = [];
  
  Future<void> loadQuotes() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/quotes.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _quotes = jsonList.map((json) => Quote.fromJson(json)).toList();
    } catch (e) {
      print('加载语录数据失败: $e');
      // 使用默认数据
      _quotes = [
        Quote(id: 1, content: '真正的平静，不是没有情绪，而是不被情绪带走。', author: '禅宗智慧', theme: '平静'),
        Quote(id: 2, content: '你不是在焦虑未来，你只是失去了当下。', author: '正念觉察', theme: '焦虑'),
      ];
    }
  }
  
  Future<Quote?> getTodayQuote() async {
    if (_quotes.isEmpty) {
      await loadQuotes();
    }
    
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_lastShownDateKey);
    final currentDate = DateTime.now().toString().split(' ')[0];
    
    if (lastDate != currentDate) {
      // 新的一天，随机选择一条语录
      final randomQuote = _getRandomQuote();
      await prefs.setString(_lastShownDateKey, currentDate);
      await prefs.setInt(_todayQuoteIdKey, randomQuote.id);
      return randomQuote;
    } else {
      // 同一天，返回之前选择的语录
      final todayQuoteId = prefs.getInt(_todayQuoteIdKey);
      if (todayQuoteId != null) {
        return _quotes.firstWhere((quote) => quote.id == todayQuoteId);
      }
      return _getRandomQuote();
    }
  }
  
  Quote _getRandomQuote() {
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }
  
  Quote getRandomQuote() {
    return _getRandomQuote();
  }
  
  int getQuotesCount() {
    return _quotes.length;
  }
}