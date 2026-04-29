#!/usr/bin/env python3

import sys
import math
import re
import time
from datetime import datetime
from PyQt6.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QGridLayout, QLineEdit, QPushButton, QTabWidget,
                             QLabel, QListWidget, QHBoxLayout, QSpinBox,
                             QComboBox, QTimeEdit, QDateEdit, QMessageBox, QCheckBox)
from PyQt6.QtCore import Qt, QTimer, QTime, QDate
from PyQt6.QtGui import QFont, QIcon

class CalculatorTab(QWidget):
    def __init__(self):
        super().__init__()
        self.main_layout = QVBoxLayout()
        self.main_layout.setContentsMargins(20, 30, 20, 20)
        self.setLayout(self.main_layout)

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
                
                open_p = eval_str.count('(')
                close_p = eval_str.count(')')
                if open_p > close_p:
                    eval_str += ')' * (open_p - close_p)
                
                result = str(eval(eval_str))
                
                if '.' in result:
                    result = str(round(float(result), 8)).rstrip('0').rstrip('.')
                    
                self.current_expression = result
            except Exception as e:
                self.current_expression = "Error"
        else:
            self.current_expression += str(key)
            
        self.display.setText(self.current_expression if self.current_expression else "0")


class StopwatchTab(QWidget):
    def __init__(self):
        super().__init__()
        layout = QVBoxLayout()
        layout.setAlignment(Qt.AlignmentFlag.AlignTop)
        self.setLayout(layout)

        self.time_label = QLabel("00:00:00.00")
        self.time_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.time_label.setFont(QFont("Inter", 48, QFont.Weight.Bold))
        self.time_label.setStyleSheet("color: #f8fafc; margin: 20px 0; background: transparent;")
        layout.addWidget(self.time_label)

        btn_layout = QHBoxLayout()
        self.start_btn = QPushButton("Iniciar")
        self.start_btn.setProperty("cssClass", "equal")
        self.start_btn.clicked.connect(self.toggle_stopwatch)
        
        self.lap_btn = QPushButton("Vuelta")
        self.lap_btn.setProperty("cssClass", "sci")
        self.lap_btn.clicked.connect(self.mark_lap)
        
        self.reset_btn = QPushButton("Reiniciar")
        self.reset_btn.setProperty("cssClass", "action")
        self.reset_btn.clicked.connect(self.reset_stopwatch)
        
        btn_layout.addWidget(self.start_btn)
        btn_layout.addWidget(self.lap_btn)
        btn_layout.addWidget(self.reset_btn)
        layout.addLayout(btn_layout)

        self.laps_list = QListWidget()
        self.laps_list.setStyleSheet("background-color: #0f172a; color: #f8fafc; border: 1px solid #334155; border-radius: 10px; font-size: 16px; padding: 5px;")
        layout.addWidget(self.laps_list)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_display)
        self.start_time = None
        self.elapsed_time = 0
        self.is_running = False

    def toggle_stopwatch(self):
        if not self.is_running:
            self.start_time = time.time() - self.elapsed_time
            self.timer.start(10) # 10ms
            self.start_btn.setText("Pausar")
            self.start_btn.setProperty("cssClass", "action")
            self.is_running = True
        else:
            self.timer.stop()
            self.start_btn.setText("Reanudar")
            self.start_btn.setProperty("cssClass", "equal")
            self.is_running = False
        
        self.start_btn.style().unpolish(self.start_btn)
        self.start_btn.style().polish(self.start_btn)

    def update_display(self):
        self.elapsed_time = time.time() - self.start_time
        self.time_label.setText(self.format_time(self.elapsed_time))

    def format_time(self, seconds):
        mins = int(seconds // 60)
        secs = int(seconds % 60)
        millis = int((seconds * 100) % 100)
        return f"{mins:02d}:{secs:02d}.{millis:02d}"

    def mark_lap(self):
        if self.is_running:
            lap_time = self.format_time(self.elapsed_time)
            lap_count = self.laps_list.count() + 1
            self.laps_list.insertItem(0, f"Vuelta {lap_count} - {lap_time}")

    def reset_stopwatch(self):
        self.timer.stop()
        self.is_running = False
        self.elapsed_time = 0
        self.time_label.setText("00:00:00.00")
        self.start_btn.setText("Iniciar")
        self.start_btn.setProperty("cssClass", "equal")
        self.start_btn.style().unpolish(self.start_btn)
        self.start_btn.style().polish(self.start_btn)
        self.laps_list.clear()


class TimerTab(QWidget):
    def __init__(self):
        super().__init__()
        layout = QVBoxLayout()
        layout.setAlignment(Qt.AlignmentFlag.AlignTop)
        self.setLayout(layout)

        input_layout = QHBoxLayout()
        
        self.h_spin = QSpinBox(); self.h_spin.setRange(0, 99); self.h_spin.setSuffix(" h")
        self.m_spin = QSpinBox(); self.m_spin.setRange(0, 59); self.m_spin.setSuffix(" m")
        self.s_spin = QSpinBox(); self.s_spin.setRange(0, 59); self.s_spin.setSuffix(" s")
        
        for spin in [self.h_spin, self.m_spin, self.s_spin]:
            spin.setStyleSheet("background-color: #0f172a; color: #f8fafc; font-size: 20px; padding: 10px; border-radius: 10px;")
            input_layout.addWidget(spin)

        layout.addLayout(input_layout)

        self.time_label = QLabel("00:00:00")
        self.time_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.time_label.setFont(QFont("Inter", 56, QFont.Weight.Bold))
        self.time_label.setStyleSheet("color: #f8fafc; margin: 20px 0; background: transparent;")
        layout.addWidget(self.time_label)

        btn_layout = QHBoxLayout()
        self.start_btn = QPushButton("Iniciar")
        self.start_btn.setProperty("cssClass", "equal")
        self.start_btn.clicked.connect(self.toggle_timer)
        
        self.reset_btn = QPushButton("Reiniciar")
        self.reset_btn.setProperty("cssClass", "action")
        self.reset_btn.clicked.connect(self.reset_timer)
        
        btn_layout.addWidget(self.start_btn)
        btn_layout.addWidget(self.reset_btn)
        layout.addLayout(btn_layout)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_display)
        self.remaining_time = 0
        self.is_running = False

    def toggle_timer(self):
        if not self.is_running:
            if self.remaining_time == 0:
                self.remaining_time = self.h_spin.value() * 3600 + self.m_spin.value() * 60 + self.s_spin.value()
            
            if self.remaining_time > 0:
                self.timer.start(1000)
                self.start_btn.setText("Pausar")
                self.start_btn.setProperty("cssClass", "action")
                self.is_running = True
                self.h_spin.setEnabled(False)
                self.m_spin.setEnabled(False)
                self.s_spin.setEnabled(False)
        else:
            self.timer.stop()
            self.start_btn.setText("Reanudar")
            self.start_btn.setProperty("cssClass", "equal")
            self.is_running = False
        
        self.start_btn.style().unpolish(self.start_btn)
        self.start_btn.style().polish(self.start_btn)
        self.update_label()

    def update_display(self):
        if self.remaining_time > 0:
            self.remaining_time -= 1
            self.update_label()
        else:
            self.timer.stop()
            self.is_running = False
            self.start_btn.setText("Iniciar")
            self.start_btn.setProperty("cssClass", "equal")
            self.start_btn.style().unpolish(self.start_btn)
            self.start_btn.style().polish(self.start_btn)
            self.h_spin.setEnabled(True)
            self.m_spin.setEnabled(True)
            self.s_spin.setEnabled(True)
            
            msg = QMessageBox(self)
            msg.setWindowTitle("Temporizador")
            msg.setText("¡El tiempo ha finalizado!")
            msg.setStyleSheet("background-color: #1e293b; color: #f8fafc;")
            msg.exec()

    def update_label(self):
        h = self.remaining_time // 3600
        m = (self.remaining_time % 3600) // 60
        s = self.remaining_time % 60
        self.time_label.setText(f"{h:02d}:{m:02d}:{s:02d}")

    def reset_timer(self):
        self.timer.stop()
        self.is_running = False
        self.remaining_time = 0
        self.update_label()
        self.start_btn.setText("Iniciar")
        self.start_btn.setProperty("cssClass", "equal")
        self.start_btn.style().unpolish(self.start_btn)
        self.start_btn.style().polish(self.start_btn)
        self.h_spin.setEnabled(True)
        self.m_spin.setEnabled(True)
        self.s_spin.setEnabled(True)


class AlarmTab(QWidget):
    def __init__(self):
        super().__init__()
        layout = QVBoxLayout()
        self.setLayout(layout)

        input_widget = QWidget()
        input_layout = QVBoxLayout()
        input_widget.setLayout(input_layout)
        input_widget.setStyleSheet("background-color: #334155; border-radius: 10px; padding: 10px;")

        time_layout = QHBoxLayout()
        self.time_edit = QTimeEdit()
        self.time_edit.setTime(QTime.currentTime())
        self.time_edit.setStyleSheet("background-color: #0f172a; color: white; padding: 5px; font-size: 18px;")
        
        time_label = QLabel("Hora:")
        time_label.setStyleSheet("color: white; font-weight: bold; background: transparent;")
        time_layout.addWidget(time_label)
        time_layout.addWidget(self.time_edit)
        
        self.type_combo = QComboBox()
        self.type_combo.addItems(["Diaria", "Fecha Específica", "Días de la semana"])
        self.type_combo.setStyleSheet("background-color: #0f172a; color: white; padding: 5px;")
        self.type_combo.currentIndexChanged.connect(self.toggle_alarm_type_inputs)
        time_layout.addWidget(self.type_combo)
        input_layout.addLayout(time_layout)

        self.date_edit = QDateEdit()
        self.date_edit.setDate(QDate.currentDate())
        self.date_edit.setStyleSheet("background-color: #0f172a; color: white; padding: 5px;")
        self.date_edit.hide()
        input_layout.addWidget(self.date_edit)

        self.days_widget = QWidget()
        self.days_widget.setStyleSheet("background: transparent;")
        days_layout = QHBoxLayout()
        days_layout.setContentsMargins(0, 0, 0, 0)
        self.days_widget.setLayout(days_layout)
        self.day_checkboxes = []
        days = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"]
        for d in days:
            cb = QCheckBox(d)
            cb.setStyleSheet("color: white; background: transparent;")
            days_layout.addWidget(cb)
            self.day_checkboxes.append(cb)
        self.days_widget.hide()
        input_layout.addWidget(self.days_widget)

        add_btn = QPushButton("Añadir Alarma")
        add_btn.setProperty("cssClass", "operator")
        add_btn.clicked.connect(self.add_alarm)
        input_layout.addWidget(add_btn)

        layout.addWidget(input_widget)

        self.alarms_list = QListWidget()
        self.alarms_list.setStyleSheet("background-color: #0f172a; color: #f8fafc; border: 1px solid #334155; border-radius: 10px; font-size: 16px; padding: 5px;")
        layout.addWidget(self.alarms_list)

        action_layout = QHBoxLayout()
        self.edit_btn = QPushButton("Editar")
        self.edit_btn.setProperty("cssClass", "sci")
        self.edit_btn.clicked.connect(self.edit_alarm)
        
        self.delete_btn = QPushButton("Eliminar")
        self.delete_btn.setProperty("cssClass", "action")
        self.delete_btn.clicked.connect(self.delete_alarm)
        
        action_layout.addWidget(self.edit_btn)
        action_layout.addWidget(self.delete_btn)
        layout.addLayout(action_layout)

        self.alarms = []
        
        self.check_timer = QTimer(self)
        self.check_timer.timeout.connect(self.check_alarms)
        self.check_timer.start(1000)

    def toggle_alarm_type_inputs(self):
        t = self.type_combo.currentText()
        if t == "Fecha Específica":
            self.date_edit.show()
            self.days_widget.hide()
        elif t == "Días de la semana":
            self.date_edit.hide()
            self.days_widget.show()
        else:
            self.date_edit.hide()
            self.days_widget.hide()

    def add_alarm(self):
        t = self.type_combo.currentText()
        alarm = {
            "time": self.time_edit.time(),
            "type": t,
            "active": True
        }
        
        desc = f"{alarm['time'].toString('HH:mm')} - {t}"
        
        if t == "Fecha Específica":
            alarm["date"] = self.date_edit.date()
            desc += f" ({alarm['date'].toString('yyyy-MM-dd')})"
        elif t == "Días de la semana":
            days = []
            days_names = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"]
            for i, cb in enumerate(self.day_checkboxes):
                if cb.isChecked():
                    days.append(i + 1)
            alarm["days"] = days
            if not days:
                msg = QMessageBox(self)
                msg.setText("Selecciona al menos un día.")
                msg.setStyleSheet("background-color: #1e293b; color: white;")
                msg.exec()
                return
            days_str = ", ".join([days_names[i-1] for i in days])
            desc += f" ({days_str})"
            
        self.alarms.append(alarm)
        self.alarms_list.addItem(desc)

    def delete_alarm(self):
        row = self.alarms_list.currentRow()
        if row >= 0:
            self.alarms_list.takeItem(row)
            self.alarms.pop(row)

    def edit_alarm(self):
        row = self.alarms_list.currentRow()
        if row >= 0:
            alarm = self.alarms[row]
            self.time_edit.setTime(alarm["time"])
            self.type_combo.setCurrentText(alarm["type"])
            
            if alarm["type"] == "Fecha Específica":
                self.date_edit.setDate(alarm["date"])
            elif alarm["type"] == "Días de la semana":
                for i, cb in enumerate(self.day_checkboxes):
                    cb.setChecked((i + 1) in alarm["days"])
            
            self.delete_alarm()

    def check_alarms(self):
        current_time = QTime.currentTime()
        current_date = QDate.currentDate()
        current_dayOfWeek = current_date.dayOfWeek()
        
        for i, alarm in enumerate(self.alarms):
            if not alarm["active"]:
                continue
                
            if current_time.hour() == alarm["time"].hour() and current_time.minute() == alarm["time"].minute() and current_time.second() == 0:
                
                trigger = False
                if alarm["type"] == "Diaria":
                    trigger = True
                elif alarm["type"] == "Fecha Específica":
                    if current_date == alarm["date"]:
                        trigger = True
                        alarm["active"] = False
                elif alarm["type"] == "Días de la semana":
                    if current_dayOfWeek in alarm["days"]:
                        trigger = True
                        
                if trigger:
                    self.show_alarm_notification(i)

    def show_alarm_notification(self, index):
        msg = QMessageBox(self)
        msg.setWindowTitle("¡Alarma!")
        msg.setText(f"Alarma de las {self.alarms[index]['time'].toString('HH:mm')}")
        msg.setStyleSheet("background-color: #1e293b; color: white; font-size: 18px;")
        msg.exec()


class MainApp(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Calculadora y Reloj")
        self.setFixedSize(540, 560)

        self.setStyleSheet("""
            QMainWindow, QWidget {
                background-color: #1e293b;
            }
            QTabWidget::pane {
                border: none;
                background-color: #1e293b;
            }
            QTabBar::tab {
                background-color: #334155;
                color: #94a3b8;
                padding: 10px 15px;
                margin-right: 2px;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                font-family: 'Inter';
                font-weight: bold;
                font-size: 14px;
            }
            QTabBar::tab:selected {
                background-color: #1e293b;
                color: #f8fafc;
                border-bottom: 3px solid #3b82f6;
            }
            QTabBar::tab:hover {
                background-color: #475569;
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
                padding: 10px;
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
            QPushButton[cssClass="num"] {
                background-color: #334155;
            }
            QMessageBox {
                background-color: #1e293b;
                color: white;
            }
            QMessageBox QLabel {
                color: white;
                background: transparent;
            }
            QMessageBox QPushButton {
                min-width: 80px;
                font-size: 14px;
            }
        """)

        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)
        
        self.calc_tab = CalculatorTab()
        self.alarm_tab = AlarmTab()
        self.timer_tab = TimerTab()
        self.stopwatch_tab = StopwatchTab()
        
        self.tabs.addTab(self.calc_tab, "Calculadora")
        self.tabs.addTab(self.alarm_tab, "Alarmas")
        self.tabs.addTab(self.timer_tab, "Temporizador")
        self.tabs.addTab(self.stopwatch_tab, "Cronómetro")

    def keyPressEvent(self, event):
        if self.tabs.currentIndex() == 0:
            key = event.text()
            valid_keys = '0123456789+-^()!e'
            if key in valid_keys:
                self.calc_tab.on_press(key)
            elif key in ['*', '×']:
                self.calc_tab.on_press('×')
            elif key in ['/', '÷']:
                self.calc_tab.on_press('÷')
            elif key == '.' or key == ',':
                self.calc_tab.on_press('.')
            elif event.key() == Qt.Key.Key_Return or event.key() == Qt.Key.Key_Enter or key == '=':
                self.calc_tab.on_press('=')
            elif event.key() == Qt.Key.Key_Backspace:
                self.calc_tab.on_press('DEL')
            elif event.key() == Qt.Key.Key_Escape:
                self.calc_tab.on_press('AC')

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainApp()
    window.show()
    sys.exit(app.exec())
