import 'package:flutter/material.dart';
import '../services/quote_service.dart';
import '../widgets/quote_card.dart';
import '../models/quote.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuoteService _quoteService = QuoteService();
  Quote? _currentQuote;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }
  
  Future<void> _initializeApp() async {
    try {
      await _quoteService.loadQuotes();
      final todayQuote = await _quoteService.getTodayQuote();
      setState(() {
        _currentQuote = todayQuote;
        _isLoading = false;
      });
    } catch (e) {
      print('初始化失败: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  void _refreshQuote() {
    setState(() {
      _currentQuote = _quoteService.getRandomQuote();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: isMobile ? EdgeInsets.all(16) : EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
                )
              else if (_currentQuote != null)
                QuoteCard(
                  quote: _currentQuote!,
                  onRefresh: _refreshQuote,
                )
              else
                Column(
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      '加载失败，请重试',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _initializeApp,
                      child: Text('重试'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}