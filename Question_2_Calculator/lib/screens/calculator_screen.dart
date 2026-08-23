import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _equation = '0';
  String _result = '0';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _equation = '0';
        _result = '0';
      } else if (buttonText == '⌫') {
        if (_equation.isNotEmpty && _equation != '0') {
          _equation = _equation.substring(0, _equation.length - 1);
          if (_equation.isEmpty) _equation = '0';
        }
      } else if (buttonText == '=') {
        _equation = _result;
      } else {
        final isOperator = _isOperator(buttonText);
        if (_equation == '0') {
          if (isOperator) {
            _equation = '0$buttonText';
          } else {
            _equation = buttonText;
          }
        } else {
          final lastChar = _equation[_equation.length - 1];
          if (isOperator && _isOperator(lastChar)) {
            _equation = _equation.substring(0, _equation.length - 1) + buttonText;
          } else {
            _equation += buttonText;
          }
        }
      }

      _result = _evaluateExpression(_equation);
    });
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷' || char == '%';
  }

  bool _isOperatorToken(String t) => t == '+' || t == '-' || t == '*' || t == '/' || t == '%';

  double _evaluate(String sanitized) {
    final tokens = <String>[];
    var currentNum = StringBuffer();
    for (var i = 0; i < sanitized.length; i++) {
      final char = sanitized[i];
      if (RegExp(r'[0-9.]').hasMatch(char)) {
        currentNum.write(char);
      } else {
        if (currentNum.isNotEmpty) {
          tokens.add(currentNum.toString());
          currentNum.clear();
        }
        if (char == '-' && (tokens.isEmpty || _isOperatorToken(tokens.last))) {
          currentNum.write(char);
        } else {
          tokens.add(char);
        }
      }
    }
    if (currentNum.isNotEmpty) {
      tokens.add(currentNum.toString());
    }

    if (tokens.isEmpty) return 0.0;

    final tempTokens = <String>[];
    var i = 0;
    while (i < tokens.length) {
      final token = tokens[i];
      if (token == '*' || token == '/' || token == '%') {
        final prevVal = double.tryParse(tempTokens.removeLast()) ?? 0.0;
        final nextVal = double.tryParse(tokens[i + 1]) ?? 0.0;
        double subVal = 0.0;
        if (token == '*') subVal = prevVal * nextVal;
        if (token == '/') subVal = nextVal == 0 ? double.infinity : prevVal / nextVal;
        if (token == '%') subVal = prevVal % nextVal;
        
        tempTokens.add(subVal.toString());
        i += 2;
      } else {
        tempTokens.add(token);
        i++;
      }
    }

    if (tempTokens.isEmpty) return 0.0;
    var resultVal = double.tryParse(tempTokens[0]) ?? 0.0;
    var j = 1;
    while (j < tempTokens.length) {
      final op = tempTokens[j];
      final nextVal = double.tryParse(tempTokens[j + 1]) ?? 0.0;
      if (op == '+') resultVal += nextVal;
      if (op == '-') resultVal -= nextVal;
      j += 2;
    }

    return resultVal;
  }

  String _evaluateExpression(String expr) {
    if (expr.isEmpty || expr == '0') return '0';

    var sanitized = expr.replaceAll('×', '*').replaceAll('÷', '/');

    while (sanitized.isNotEmpty &&
        (sanitized.endsWith('+') ||
            sanitized.endsWith('-') ||
            sanitized.endsWith('*') ||
            sanitized.endsWith('/') ||
            sanitized.endsWith('%'))) {
      sanitized = sanitized.substring(0, sanitized.length - 1);
    }

    if (sanitized.isEmpty) return '0';

    try {
      final value = _evaluate(sanitized);
      if (value.isInfinite || value.isNaN) return 'Error';
      if (value == value.toInt()) {
        return value.toInt().toString();
      }
      return value.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    } catch (_) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F12),
      appBar: AppBar(
        title: const Text(
          'Calculator (Q2)',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          _equation,
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _result,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton('AC', color: const Color(0xFFE2E8F0), textColor: Colors.black),
                      _buildButton('⌫', color: const Color(0xFF475569), textColor: Colors.white),
                      _buildButton('%', color: const Color(0xFF475569), textColor: Colors.white),
                      _buildButton('÷', color: Colors.cyan.shade700, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('×', color: Colors.cyan.shade700, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('-', color: Colors.cyan.shade700, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('+', color: Colors.cyan.shade700, textColor: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton('0', flex: 2),
                      _buildButton('.'),
                      _buildButton('=', color: Colors.emerald.shade600, textColor: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text, {
    Color? color,
    Color? textColor,
    int flex = 1,
  }) {
    final bgColor = color ?? const Color(0xFF1E293B);
    final txtColor = textColor ?? Colors.white;

    return Expanded(
      flex: flex,
      child: Container(
        height: 76,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Material(
            color: bgColor,
            child: InkWell(
              onTap: () => _onButtonPressed(text),
              splashColor: txtColor.withOpacity(0.2),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: txtColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
