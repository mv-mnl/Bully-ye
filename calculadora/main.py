#!/usr/bin/env python3

import sys
import math
import re
from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QGridLayout, QLineEdit, QPushButton)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QFont

class Calculator(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Calculadora Científica")
        self.setFixedSize(540, 520)

        # Main widget & layout
        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)
        self.main_layout = QVBoxLayout()
        self.main_layout.setContentsMargins(20, 30, 20, 20)
        self.central_widget.setLayout(self.main_layout)

        # Styles (Dark Mode)
        self.setStyleSheet("""
            QMainWindow {
                background-color: #1e293b;
            }
            QLineEdit {
                background-color: #0f172a;
                color: #f8fafc;
                border: 1px solid #334155;
                border-radius: 10px;
                padding: 10px;
                font-family: 'Inter';
            }
            QPushButton {
                background-color: #334155;
                color: #f8fafc;
                border: none;
                border-radius: 12px;
                font-family: 'Inter';
                font-size: 20px;
            }
            QPushButton:hover {
                background-color: #475569;
            }
            QPushButton[cssClass="action"] {
                background-color: #ef4444;
            }
            QPushButton[cssClass="action"]:hover {
                background-color: #dc2626;
            }
            QPushButton[cssClass="operator"] {
                background-color: #3b82f6;
            }
            QPushButton[cssClass="operator"]:hover {
                background-color: #2563eb;
            }
            QPushButton[cssClass="sci"] {
                background-color: #4b5563;
                font-size: 18px;
            }
            QPushButton[cssClass="sci"]:hover {
                background-color: #6b7280;
            }
            QPushButton[cssClass="equal"] {
                background-color: #10b981;
            }
            QPushButton[cssClass="equal"]:hover {
                background-color: #059669;
            }
        """)

        # Display
        self.display = QLineEdit()
        self.display.setReadOnly(True)
        self.display.setAlignment(Qt.AlignmentFlag.AlignRight)
        
        font = QFont("Inter", 36, QFont.Weight.Bold)
        self.display.setFont(font)
        self.display.setText("0")
        self.main_layout.addWidget(self.display)
        self.main_layout.addSpacing(15)

        # Grid Layout for buttons
        self.grid = QGridLayout()
        self.grid.setSpacing(8)
        self.main_layout.addLayout(self.grid)

        # Define buttons
        buttons = [
            ('sin(', 0, 0, 1, 1, 'sci'), ('cos(', 0, 1, 1, 1, 'sci'), ('tan(', 0, 2, 1, 1, 'sci'), ('AC', 0, 3, 1, 2, 'action'), ('DEL', 0, 5, 1, 1, 'action'), ('÷', 0, 6, 1, 1, 'operator'),
            ('ln(', 1, 0, 1, 1, 'sci'), ('log(', 1, 1, 1, 1, 'sci'), ('√(', 1, 2, 1, 1, 'sci'), ('7', 1, 3, 1, 1, 'num'), ('8', 1, 4, 1, 1, 'num'), ('9', 1, 5, 1, 1, 'num'), ('×', 1, 6, 1, 1, 'operator'),
            ('π', 2, 0, 1, 1, 'sci'), ('e', 2, 1, 1, 1, 'sci'), ('^', 2, 2, 1, 1, 'sci'), ('4', 2, 3, 1, 1, 'num'), ('5', 2, 4, 1, 1, 'num'), ('6', 2, 5, 1, 1, 'num'), ('-', 2, 6, 1, 1, 'operator'),
            ('(', 3, 0, 1, 1, 'sci'), (')', 3, 1, 1, 1, 'sci'), ('!', 3, 2, 1, 1, 'sci'), ('1', 3, 3, 1, 1, 'num'), ('2', 3, 4, 1, 1, 'num'), ('3', 3, 5, 1, 1, 'num'), ('+', 3, 6, 1, 1, 'operator'),
            ('arcsin(', 4, 0, 1, 1, 'sci'),('arccos(', 4, 1, 1, 1, 'sci'),('arctan(', 4, 2, 1, 1, 'sci'),('0', 4, 3, 1, 2, 'num'), ('.', 4, 5, 1, 1, 'num'), ('=', 4, 6, 1, 1, 'equal')
        ]

        for text, row, col, rowspan, colspan, css_class in buttons:
            btn = QPushButton(text)
            btn.setSizePolicy(btn.sizePolicy().Policy.Expanding, btn.sizePolicy().Policy.Expanding)
            btn.setProperty("cssClass", css_class)
            btn.clicked.connect(lambda ch, t=text: self.on_press(t))
            self.grid.addWidget(btn, row, col, rowspan, colspan)
            
        self.current_expression = ""

    def validate_eval_str(self, expr):
        """Replaces mathematical symbols with math functions."""
        expr = expr.replace('×', '*').replace('÷', '/')
        expr = expr.replace('π', str(math.pi)).replace('e', str(math.e))
        expr = expr.replace('^', '**')
        expr = expr.replace('sin(', 'math.sin(')
        expr = expr.replace('cos(', 'math.cos(')
        expr = expr.replace('tan(', 'math.tan(')
        expr = expr.replace('arcsin(', 'math.asin(')
        expr = expr.replace('arccos(', 'math.acos(')
        expr = expr.replace('arctan(', 'math.atan(')
        expr = expr.replace('ln(', 'math.log(')
        expr = expr.replace('log(', 'math.log10(')
        expr = expr.replace('√(', 'math.sqrt(')
        
        # Factorial processing using regex
        while '!' in expr:
            match = re.search(r'(\d+|\([^)]+\))!', expr)
            if match:
                num = match.group(1)
                expr = expr[:match.start()] + f"math.factorial({num})" + expr[match.end():]
            else:
                break
        return expr

    def on_press(self, key):
        if self.current_expression == "Error":
            self.current_expression = ""

        if key == 'AC':
            self.current_expression = ""
        elif key == 'DEL':
            if len(self.current_expression) > 0:
                if self.current_expression.endswith('sin(') or self.current_expression.endswith('cos(') or self.current_expression.endswith('tan(') or self.current_expression.endswith('log('):
                    self.current_expression = self.current_expression[:-4]
                elif self.current_expression.endswith('arcsin(') or self.current_expression.endswith('arccos(') or self.current_expression.endswith('arctan('):
                    self.current_expression = self.current_expression[:-7]
                elif self.current_expression.endswith('ln(') or self.current_expression.endswith('√('):
                    self.current_expression = self.current_expression[:-3]
                else:
                    self.current_expression = self.current_expression[:-1]
        elif key == '=':
            try:
                if self.current_expression.strip() == "":
                    return
                eval_str = self.validate_eval_str(self.current_expression)
                
                # Check for open parentheses
                open_p = eval_str.count('(')
                close_p = eval_str.count(')')
                if open_p > close_p:
                    eval_str += ')' * (open_p - close_p)
                
                result = str(eval(eval_str))
                
                # Format to not be excessively long
                if '.' in result:
                    result = str(round(float(result), 8)).rstrip('0').rstrip('.')
                    
                self.current_expression = result
            except Exception as e:
                self.current_expression = "Error"
        else:
            self.current_expression += str(key)
            
        self.display.setText(self.current_expression if self.current_expression else "0")

    def keyPressEvent(self, event):
        key = event.text()
        valid_keys = '0123456789+-^()!e'
        if key in valid_keys:
            self.on_press(key)
        elif key in ['*', '×']:
            self.on_press('×')
        elif key in ['/', '÷']:
            self.on_press('÷')
        elif key == '.' or key == ',':
            self.on_press('.')
        elif event.key() == Qt.Key.Key_Return or event.key() == Qt.Key.Key_Enter or key == '=':
            self.on_press('=')
        elif event.key() == Qt.Key.Key_Backspace:
            self.on_press('DEL')
        elif event.key() == Qt.Key.Key_Escape:
            self.on_press('AC')

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = Calculator()
    window.show()
    sys.exit(app.exec())
