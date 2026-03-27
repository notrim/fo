import 'package:flutter/material.dart';
import '../models/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final VoidCallback onRefresh;
  
  const QuoteCard({
    Key? key,
    required this.quote,
    required this.onRefresh,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Column(
      children: [
        // 语录卡片
        Container(
          width: double.infinity,
          padding: isMobile ? EdgeInsets.all(16) : EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // 语录内容
              Text(
                quote.content,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  height: 1.6,
                  color: Colors.black87,
                  fontFamily: 'NotoSerifSC',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 12 : 16),
              // 作者信息
              if (quote.author.isNotEmpty)
                Text(
                  '—— ${quote.author}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 32),
        // 刷新按钮
        ElevatedButton.icon(
          onPressed: onRefresh,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          icon: Icon(Icons.autorenew, size: 18),
          label: Text('再来一句', style: TextStyle(fontSize: 16)),
        ),
        SizedBox(height: 16),
        // 主题标签
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '#${quote.theme}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.brown,
            ),
          ),
        ),
      ],
    );
  }
}