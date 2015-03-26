<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<?xml-stylesheet ekr_test?>
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="amd.20150318155833.44"><vh>@settings</vh>
<v t="amd.20150318155833.45"><vh>@data qt-gui-plugin-style-sheet</vh></v>
<v t="amd.20150318155833.46"><vh>@string initial_split_orientation = horizontal</vh></v>
<v t="amd.20150318155833.47"><vh>@string rst3_write_intermediate_extension = .rst</vh></v>
</v>
<v t="amd.20150318154017.40"><vh>Tetris</vh></v>
<v t="amd.20150318154611.40"><vh>PyQt4 version</vh></v>
<v t="amd.20150318155833.40"><vh>getinput</vh></v>
<v t="amd.20150318155833.49"><vh>@button new to wp</vh></v>
<v t="amd.20150319203708.48"><vh>@button edit to wp</vh></v>
<v t="amd.20150319203708.45"><vh>Leo Editor API</vh></v>
<v t="amd.20150320090250.45" a="E"><vh>利用 Leo Editor 作為 Wordpress client</vh>
<v t="amd.20150323191758.5"><vh>已知問題</vh></v>
<v t="amd.20150320090250.42" a="E"><vh>demo-2015course.rhcloud.com</vh>
<v t="amd.20150318155833.50" a="E"><vh>這是第1週的心得</vh>
<v t="amd.20150321081347.44"><vh>文章 id</vh></v>
</v>
<v t="amd.20150319203708.49" a="E"><vh>這是第2週的小小心得 </vh>
<v t="amd.20150321081347.45"><vh>文章 id</vh></v>
</v>
</v>
<v t="amd.20150320090250.47" a="E"><vh>wordpress-2015course.rhcloud.com</vh>
<v t="amd.20150323191758.7"><vh>Scrum 團隊資料</vh></v>
<v t="amd.20150321081347.47"><vh>寫網誌的格式</vh></v>
<v t="amd.20150323191758.4" a="E"><vh>協同專案執行範例</vh>
<v t="amd.20150323191758.6"><vh>文章 id</vh></v>
</v>
<v t="amd.20150322185151.11" a="E"><vh>Easy Wordpress Guide 重點</vh>
<v t="amd.20150322185151.12"><vh>文章 id</vh></v>
</v>
<v t="amd.20150322185151.13" a="E"><vh>Scrum in Mechanical Product Development</vh>
<v t="amd.20150322185151.14"><vh>文章 id</vh></v>
</v>
</v>
<v t="amd.20150320090250.46" a="E"><vh>wordpress-chiamingyen.rhcloud.com</vh>
<v t="amd.20150321081347.46"><vh>寫網誌的格式</vh></v>
<v t="amd.20150326092950.3"><vh>@url 連結網誌</vh></v>
<v t="amd.20150326093802.57"><vh>使用 Docker 執行 Taiga</vh>
<v t="amd.20150326120643.3"><vh>文章 id</vh></v>
</v>
<v t="amd.20150321081347.48" a="E"><vh>Leo Editor 再出發</vh>
<v t="amd.20150321081347.49"><vh>文章 id</vh></v>
</v>
</v>
</v>
<v t="amd.20150318155833.51" a="E"><vh>節點資料應用範例</vh>
<v t="amd.20150321081347.40"><vh>p 的用法</vh></v>
<v t="amd.20150320090250.40"><vh>從檔案讀取帳號密碼</vh></v>
</v>
<v t="amd.20150318155833.41" a="E"><vh>send to wp</vh>
<v t="amd.20150318155833.42"><vh>基本操作流程</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="amd.20150318154017.40">#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""

Tetяis

    Keys
    --------------------------------------------------
    left   : request to translate left by one column
    right  : request to translate right by one column
    up     : request to do a counterclockwise rotation
    down   : request to translate down by one row

__author__ = 'Leonardo Vidarte'

"""

import time
import random
import copy

import tkinter as tk
from tkinter import messagebox as tkMessageBox



# ===============================================
# WINDOW OPTIONS
# ===============================================
BG_COLOR = 'black'

# Board
BOARD_BG_COLOR = 'black'
BOARD_FG_COLOR = 'white'
BOARD_GRID_COLOR = '#333'

# Status
FONT_SIZE = 12
FONT_COLOR = 'white'

# Tetrominos
TETROMINO_FG_COLOR = 'black'
TETROMINO_BORDER_WIDTH = 2 # in pixels
I_COLOR = 'cyan'
O_COLOR = 'yellow'
T_COLOR = 'magenta'
J_COLOR = 'blue'
L_COLOR = 'orange'
S_COLOR = 'green'
Z_COLOR = 'red'
COMPLETE_ROW_BG_COLOR = 'white' # None for inherit
COMPLETE_ROW_FG_COLOR = None
# ===============================================


# Levels
LEVEL_0_DELAY = 1000 # inital delay between steps
ROWS_BY_LEVEL = 10
POINTS = [40, 100, 300, 1200] # 1 , 2, 3, Tetris

# 
WIDTH = 10
HEIGHT = 20
SIZE = 20 # square size in pixels

# Tetrominos
I = (
     ((0,0,0,0),
      (1,1,1,1),
      (0,0,0,0),
      (0,0,0,0)),
     ((0,1,0,0),
      (0,1,0,0),
      (0,1,0,0),
      (0,1,0,0)),
     )

O = (
     ((1,1),
      (1,1)),
     )

T = (
     ((0,0,0),
      (1,1,1),
      (0,1,0)),
     ((0,1,0),
      (1,1,0),
      (0,1,0)),
     ((0,1,0),
      (1,1,1),
      (0,0,0)),
     ((0,1,0),
      (0,1,1),
      (0,1,0)),
     )

J = (
     ((0,1,0),
      (0,1,0),
      (1,1,0)),
     ((1,0,0),
      (1,1,1),
      (0,0,0)),
     ((0,1,1),
      (0,1,0),
      (0,1,0)),
     ((0,0,0),
      (1,1,1),
      (0,0,1)),
     )

L = (
     ((0,1,0),
      (0,1,0),
      (0,1,1)),
     ((0,0,0),
      (1,1,1),
      (1,0,0)),
     ((1,1,0),
      (0,1,0),
      (0,1,0)),
     ((0,0,1),
      (1,1,1),
      (0,0,0)),
     )

S = (
     ((0,0,0),
      (0,1,1),
      (1,1,0)),
     ((1,0,0),
      (1,1,0),
      (0,1,0)),
     )

Z = (
     ((0,0,0),
      (1,1,0),
      (0,1,1)),
     ((0,0,1),
      (0,1,1),
      (0,1,0)),
     )



class Application(tk.Frame):

    def __init__(self, width=WIDTH, height=HEIGHT, size=SIZE):
        tk.Frame.__init__(self, bg=BG_COLOR)
        self.grid()
        self.width = width
        self.height = height
        self.size = size
        self.create_widgets()
        self.draw_grid()
        self.create_events()
        self.tetrominos = self.get_tetrominos()
        self.game_init()

    def create_widgets(self):
        top = self.winfo_toplevel()
        top.config(bg=BG_COLOR)

        width = self.width * self.size
        height = self.height * self.size
        self.canvas = tk.Canvas(self, width=width, height=height,
                                bg=BOARD_BG_COLOR,
                                highlightbackground=BOARD_FG_COLOR)
        self.canvas.grid(row=0, column=0, padx=20, pady=20)

        lb_status = self.lb_status = tk.Label(
            self, bg=BG_COLOR, fg=FONT_COLOR, font=('monospace', FONT_SIZE))
        lb_status.grid(row=0, column=1, padx=(0, 20), pady=20, sticky=tk.N)

    def draw_grid(self):
        for i in range(self.width - 1):
            x = (self.size * i) + self.size
            y0 = 0
            y1 = self.size * self.height
            self.canvas.create_line(x, y0, x, y1, fill=BOARD_GRID_COLOR)
        for i in range(self.height - 1):
            x0 = 0
            x1 = self.size * self.width
            y = (self.size * i) + self.size
            self.canvas.create_line(x0, y, x1, y, fill=BOARD_GRID_COLOR)

    def create_events(self):
        self.canvas.bind_all('&lt;KeyPress-Up&gt;', self.rotate)
        self.canvas.bind_all('&lt;KeyPress-Down&gt;', self.move)
        self.canvas.bind_all('&lt;KeyPress-Left&gt;', self.move)
        self.canvas.bind_all('&lt;KeyPress-Right&gt;', self.move)

    def get_tetrominos(self):
        tetrominos = []
        for name in 'IOTLJSZ':
            tetromino = globals()[name]
            data = {
                'name'  : name,
                'pieces': tetromino,
                'actual': 0,
                'color' : globals()[name + '_COLOR'],
                'coords': self.get_init_coords(tetromino),
                'rows': len(tetromino[0]),
                'cols': len(tetromino[0][0]),
                'total_pieces': len(tetromino),
                'can_rotate'  : True if len(tetromino) &gt; 1 else False,
                'ids': [],
                }
            tetrominos.append(data)
        return tetrominos

    def get_init_coords(self, tetromino):
        return (int(self.width / 2.0 - len(tetromino[0]) / 2.0), 1)

    def game_init(self):
        self.board = self.get_init_board()
        self.next = copy.deepcopy(random.choice(self.tetrominos))
        self.tetromino = None
        self.status = self.get_init_status()
        self.delay = LEVEL_0_DELAY
        self.job_id = None
        self.running = True
        self.step()

    def get_init_board(self):
        if getattr(self, 'board', None) is None:
            self.board = [[0] * self.width for _ in range(self.height)]
        else:
            for y in range(self.height):
                for x in range(self.width):
                    if self.board[y][x]:
                        self.canvas.delete(self.board[y][x])
                        self.board[y][x] = 0
        return self.board

    def get_init_status(self):
        return {'score': 0, 'rows': 0, 'level': 0,
                'O': 0, 'I': 0, 'S': 0, 'T': 0, 'Z': 0, 'L': 0, 'J': 0,
                'total': 0, 'next': ''}

    def step(self):
        if self.tetromino and self.can_be_moved('Down'):
            self.move_tetromino((0, 1))
            self.job_id = self.canvas.after(self.delay, self.step)
        else:
            self.check_status()
            if self.is_gameover(self.next):
                title = 'Game Over'
                message = 'Your score: %d' % self.status['score']
                tkMessageBox.showinfo(title, message)
                self.game_init()
            else:
                self.tetromino = self.next
                self.next = copy.deepcopy(random.choice(self.tetrominos))
                self.status[self.tetromino['name']] += 1
                self.status['total'] += 1
                self.status['next'] = self.next['name']
                self.update_label_status()
                self.draw_tetromino()
                self.job_id = self.canvas.after(self.delay, self.step)

    def check_status(self):
        rows = []
        for row in range(self.height):
            if 0 not in self.board[row]:
                rows.append(row)
        if rows:
            self.del_rows(rows)
            self.set_score(rows)

    def del_rows(self, rows):
        for row in rows:
            for id in self.board[row]:
                self.canvas.tag_raise(id) # bring to front
                self.canvas.itemconfig(id, fill=COMPLETE_ROW_BG_COLOR,
                                       outline=COMPLETE_ROW_FG_COLOR)
        self.canvas.update()
        time.sleep(0.5)
        for row in rows:
            for id in self.board[row]:
                self.canvas.delete(id)
            del self.board[row]
            self.board.insert(0, [0] * self.width)
            for row0 in range(row + 1):
                for id0 in self.board[row0]:
                    self.canvas.move(id0, 0, self.size)
        self.canvas.update()

    def set_score(self, rows):
        points = POINTS[len(rows) - 1]
        self.status['rows'] += len(rows)
        if self.status['rows'] % ROWS_BY_LEVEL == 0:
            self.status['level'] += 1
            if self.delay &gt; 100:
                self.delay -= 100
        self.status['score'] += points
        self.update_label_status()

    def update_label_status(self):
        lines = [
            'Score: %6s' % self.status['score'],
            '',
            'Level: %6s' % self.status['level'],
            'Rows : %6s' % self.status['rows'],
            '',
            'O    : %6s' % self.status['O'],
            'I    : %6s' % self.status['I'],
            'J    : %6s' % self.status['J'],
            'L    : %6s' % self.status['L'],
            'T    : %6s' % self.status['T'],
            'S    : %6s' % self.status['S'],
            'Z    : %6s' % self.status['Z'],
            'Total: %6s' % self.status['total'],
            '',
            'Next : %6s' % self.status['next'],
            ] 
        self.lb_status.config(text='\n'.join(lines))

    def is_gameover(self, next):
        x, y = next['coords']
        for y0 in range(next['rows']):
            for x0 in range(next['cols']):
                x1 = x0 + x
                y1 = y0 + y
                if self.board[y1][x1]:
                    self.running = False
                    self.canvas.after_cancel(self.job_id)
                    return True
        return False

    def draw_tetromino(self):
        self.del_tetromino()
        piece = self.tetromino['pieces'][self.tetromino['actual']]
        x0, y0 = self.tetromino['coords']
        for y in range(self.tetromino['rows']):
            for x in range(self.tetromino['cols']):
                if piece[y][x] == 1:
                    x1 = (x0 + x) * self.size
                    y1 = (y0 + y) * self.size
                    x2 = x1 + self.size
                    y2 = y1 + self.size
                    id = self.canvas.create_rectangle(
                            x1, y1, x2, y2, width=TETROMINO_BORDER_WIDTH,
                            outline=TETROMINO_FG_COLOR,
                            fill=self.tetromino['color'])
                    self.tetromino['ids'].append(id)
                    self.board[y0 + y][x0 + x] = id
        self.canvas.update()

    def del_tetromino(self):
        if self.tetromino['ids']:
            for y in range(self.height):
                for x in range(self.width):
                    if self.board[y][x] in self.tetromino['ids']:
                        self.board[y][x] = 0
            for id in self.tetromino['ids']:
                self.canvas.delete(id)
            self.tetromino['ids'] = []

    def rotate(self, event):
        if self.tetromino['can_rotate']:
            if self.tetromino['actual'] &lt; self.tetromino['total_pieces'] - 1:
                next = self.tetromino['actual'] + 1
            else:
                next = 0
            if self.can_be_rotated(next):
                self.tetromino['actual'] = next
                self.draw_tetromino()

    def can_be_rotated(self, next):
        piece = self.tetromino['pieces'][next]
        board = self.board
        x, y = self.tetromino['coords']
        for y0 in range(self.tetromino['rows']):
            for x0 in range(self.tetromino['cols']):
                if piece[y0][x0] == 1:
                    if x == -1 and x0 == 1:
                        return False
                    if x + x0 &gt;= self.width:
                        return False
                    if y + y0 &gt;= self.height:
                        return False
                    x1 = x + x0
                    y1 = y + y0
                    if board[y1][x1] and \
                       (board[y1][x1] not in self.tetromino['ids']):
                        return False
        return True

    def move(self, event):
        if self.running and self.can_be_moved(event.keysym):
            x, y = self.tetromino['coords']
            if event.keysym == 'Left':
                self.move_tetromino((-1, 0))
            if event.keysym == 'Right':
                self.move_tetromino((1, 0))
            if event.keysym == 'Down':
                self.canvas.after_cancel(self.job_id)
                self.move_tetromino((0, 1))
                self.job_id = self.canvas.after(self.delay, self.step)

    def move_tetromino(self, offset):
        x, y = offset
        ranges = {
            (-1, 0): ((0, self.width, 1), (0, self.height, 1)),
            ( 1, 0): ((self.width-1, -1, -1), (0, self.height, 1)),
            ( 0, 1): ((0, self.width, 1), (self.height-1, -1, -1))
            }

        x_start_stop_step, y_start_stop_step = ranges[offset]
        for y0 in range(*y_start_stop_step):
            for x0 in range(*x_start_stop_step):
                id = self.board[y0][x0]
                if id in self.tetromino['ids']:
                    self.board[y0 + y][x0 + x] = self.board[y0][x0]
                    self.board[y0][x0] = 0
                    self.canvas.move(id, x * self.size, y * self.size)

        x1, y1 = self.tetromino['coords']
        self.tetromino['coords'] = (x1 + x, y1 + y)
        self.canvas.update()

    def can_be_moved(self, direction):
        piece = self.tetromino['pieces'][self.tetromino['actual']]
        board = self.board
        x, y = self.tetromino['coords']
        for y0 in range(self.tetromino['rows']):
            for x0 in range(self.tetromino['cols']):
                if piece[y0][x0] == 1:
                    if direction == 'Left':
                        x1 = x + x0 - 1
                        y1 = y + y0
                        if x1 &lt; 0 or (board[y1][x1] and
                           board[y1][x1] not in self.tetromino['ids']):
                            return False
                    if direction == 'Right':
                        x1 = x + x0 + 1
                        y1 = y + y0
                        if x1 &gt;= self.width or (board[y1][x1] and
                           board[y1][x1] not in self.tetromino['ids']):
                            return False
                    if direction == 'Down':
                        x1 = x + x0
                        y1 = y + y0 + 1
                        if y1 &gt;= self.height or (board[y1][x1] and
                           board[y1][x1] not in self.tetromino['ids']):
                            return False
        return True


prog = u'Tetяis'

from optparse import OptionParser
parser = OptionParser(description=prog)
parser.add_option('-W', '--width', type=int, default=WIDTH,
                  help="board width")
parser.add_option('-H', '--height', type=int, default=HEIGHT,
                  help="board height")
parser.add_option('-s', '--size', type=int, default=SIZE,
                  help="square size")
parser.add_option('-t', '--theme', type=str, default=None,
                  help="color config file")
args, _ = parser.parse_args()

if args.theme:
    if args.theme.endswith('.py'):
        args.theme = args.theme[:-3]
    try:
        exec('from %s import *' % args.theme)
    except ImportError:
        pass

app = Application(args.width, args.height, args.size)
app.master.title(prog)
app.mainloop()
</t>
<t tx="amd.20150318154611.40">
#coding: utf-8
# source: http://zetcode.com/tutorials/pyqt4/thetetrisgame/
# tetris.py

import sys
import random
from PyQt4 import QtCore, QtGui

class Tetris(QtGui.QMainWindow):
    def __init__(self):
        QtGui.QMainWindow.__init__(self)
        
        self.setGeometry(300, 300, 180, 380)
        self.setWindowTitle("俄羅斯方塊")
        self.tetrisboard = Board(self)
        self.setCentralWidget(self.tetrisboard)
        self.statusbar = self.statusBar()
        self.connect(self.tetrisboard, QtCore.SIGNAL("messageToStatusbar(QString)"), 
        self.statusbar, QtCore.SLOT("showMessage(QString)"))
        self.tetrisboard.start()
        self.center()

    def center(self):
        screen = QtGui.QDesktopWidget().screenGeometry()
        size =  self.geometry()
        self.move((screen.width()-size.width())/2,(screen.height()-size.height())/2)

class Board(QtGui.QFrame):
    BoardWidth = 10
    BoardHeight = 22
    Speed = 300

    def __init__(self, parent):
        QtGui.QFrame.__init__(self, parent)
        self.timer = QtCore.QBasicTimer()
        self.isWaitingAfterLine = False
        self.curPiece = Shape()
        self.nextPiece = Shape()
        self.curX = 0
        self.curY = 0
        self.numLinesRemoved = 0
        self.board = []
        self.setFocusPolicy(QtCore.Qt.StrongFocus)
        self.isStarted = False
        self.isPaused = False
        self.clearBoard()

        self.nextPiece.setRandomShape()

    def shapeAt(self, x, y):
        return self.board[int((y * Board.BoardWidth) + x)]

    def setShapeAt(self, x, y, shape):
        self.board[int((y * Board.BoardWidth) + x)] = shape

    def squareWidth(self):
        return self.contentsRect().width() / Board.BoardWidth

    def squareHeight(self):
        return self.contentsRect().height() / Board.BoardHeight

    def start(self):
        if self.isPaused:
            return
            
        self.isStarted = True
        self.isWaitingAfterLine = False
        self.numLinesRemoved = 0
        self.clearBoard()
        self.emit(QtCore.SIGNAL("messageToStatusbar(QString)"), str(self.numLinesRemoved))
        self.newPiece()
        self.timer.start(Board.Speed, self)

    def pause(self):
        if not self.isStarted:
            return
            
        self.isPaused = not self.isPaused
        if self.isPaused:
            self.timer.stop()
            self.emit(QtCore.SIGNAL("messageToStatusbar(QString)"), "paused")
        else:
            self.timer.start(Board.Speed, self)
            self.emit(QtCore.SIGNAL("messageToStatusbar(QString)"), str(self.numLinesRemoved))
        
        self.update()

    def paintEvent(self, event):
        painter = QtGui.QPainter(self)
        rect = self.contentsRect()
        boardTop = rect.bottom() - Board.BoardHeight * self.squareHeight()
        
        for i in range(Board.BoardHeight):
            for j in range(Board.BoardWidth):
                shape = self.shapeAt(j, Board.BoardHeight - i - 1)
                if shape != Tetrominoes.NoShape:
                    self.drawSquare(painter, 
                    rect.left() + j * self.squareWidth(), 
                    boardTop + i * self.squareHeight(), shape)
                    
        if self.curPiece.shape() != Tetrominoes.NoShape:
            for i in range(4):
                x = self.curX + self.curPiece.x(i)
                y = self.curY - self.curPiece.y(i)
                self.drawSquare(painter, rect.left() + x * self.squareWidth(),
                    boardTop + (Board.BoardHeight - y - 1) * self.squareHeight(),
                    self.curPiece.shape())

    def keyPressEvent(self, event):
        if not self.isStarted or self.curPiece.shape() == Tetrominoes.NoShape:
            QtGui.QWidget.keyPressEvent(self, event)
            return
            
        key = event.key()
        # 按下 p 鍵, 程式會暫停
        if key == QtCore.Qt.Key_P:
            self.pause()
            return
        if self.isPaused:
            return
        # 利用左右下上等建來翻轉方塊
        elif key == QtCore.Qt.Key_Left:
            self.tryMove(self.curPiece, self.curX - 1, self.curY)
        elif key == QtCore.Qt.Key_Right:
            self.tryMove(self.curPiece, self.curX + 1, self.curY)
        elif key == QtCore.Qt.Key_Down:
            self.tryMove(self.curPiece.rotatedRight(), self.curX, self.curY)
        elif key == QtCore.Qt.Key_Up:
            self.tryMove(self.curPiece.rotatedLeft(), self.curX, self.curY)
        # 按下 Space 鍵會 dropDown(), 直接落下
        elif key == QtCore.Qt.Key_Space:
            self.dropDown()
        # 按下 D 鍵則方塊往下一行
        elif key == QtCore.Qt.Key_D:
            self.oneLineDown()
        else:
            QtGui.QWidget.keyPressEvent(self, event)

    def timerEvent(self, event):
        if event.timerId() == self.timer.timerId():
            if self.isWaitingAfterLine:
                self.isWaitingAfterLine = False
                self.newPiece()
            else:
                self.oneLineDown()
        else:
            QtGui.QFrame.timerEvent(self, event)

    def clearBoard(self):
        for i in range(Board.BoardHeight * Board.BoardWidth):
            self.board.append(Tetrominoes.NoShape)

    def dropDown(self):
        newY = self.curY
        while newY &gt; 0:
            if not self.tryMove(self.curPiece, self.curX, newY - 1):
                break
            newY -= 1
        self.pieceDropped()

    def oneLineDown(self):
        if not self.tryMove(self.curPiece, self.curX, self.curY - 1):
            self.pieceDropped()

    def pieceDropped(self):
        for i in range(4):
            x = self.curX + self.curPiece.x(i)
            y = self.curY - self.curPiece.y(i)
            self.setShapeAt(x, y, self.curPiece.shape())
        self.removeFullLines()
        if not self.isWaitingAfterLine:
            self.newPiece()

    def removeFullLines(self):
        numFullLines = 0
        rowsToRemove = []
        for i in range(Board.BoardHeight):
            n = 0
            for j in range(Board.BoardWidth):
                if not self.shapeAt(j, i) == Tetrominoes.NoShape:
                    n = n + 1
            if n == 10:
                rowsToRemove.append(i)
        rowsToRemove.reverse()
        
        for m in rowsToRemove:
            for k in range(m, Board.BoardHeight):
                for l in range(Board.BoardWidth):
                    self.setShapeAt(l, k, self.shapeAt(l, k + 1))
        
        numFullLines = numFullLines + len(rowsToRemove)

        if numFullLines &gt; 0:
            self.numLinesRemoved = self.numLinesRemoved + numFullLines
            self.emit(QtCore.SIGNAL("messageToStatusbar(QString)"), str(self.numLinesRemoved))
            self.isWaitingAfterLine = True
            self.curPiece.setShape(Tetrominoes.NoShape)
            self.update()

    def newPiece(self):
        self.curPiece = self.nextPiece
        self.nextPiece.setRandomShape()
        self.curX = Board.BoardWidth / 2 + 1
        self.curY = Board.BoardHeight - 1 + self.curPiece.minY()
        if not self.tryMove(self.curPiece, self.curX, self.curY):
            self.curPiece.setShape(Tetrominoes.NoShape)
            self.timer.stop()
            self.isStarted = False
            self.emit(QtCore.SIGNAL("messageToStatusbar(QString)"), "Game over")



    def tryMove(self, newPiece, newX, newY):
        for i in range(4):
            x = newX + newPiece.x(i)
            y = newY - newPiece.y(i)
            if x &lt; 0 or x &gt;= Board.BoardWidth or y &lt; 0 or y &gt;= Board.BoardHeight:
                return False
            if self.shapeAt(x, y) != Tetrominoes.NoShape:
                return False
        self.curPiece = newPiece
        self.curX = newX
        self.curY = newY
        self.update()
        return True

    def drawSquare(self, painter, x, y, shape):
        colorTable = [0x000000, 0xCC6666, 0x66CC66, 0x6666CC,
                      0xCCCC66, 0xCC66CC, 0x66CCCC, 0xDAAA00]
        color = QtGui.QColor(colorTable[shape])
        painter.fillRect(x + 1, y + 1, self.squareWidth() - 2, self.squareHeight() - 2, color)
        painter.setPen(color.light())
        painter.drawLine(x, y + self.squareHeight() - 1, x, y)
        painter.drawLine(x, y, x + self.squareWidth() - 1, y)
        painter.setPen(color.dark())
        painter.drawLine(x + 1, y + self.squareHeight() - 1,
            x + self.squareWidth() - 1, y + self.squareHeight() - 1)
        painter.drawLine(x + self.squareWidth() - 1, y + self.squareHeight() - 1, x + self.squareWidth() - 1, y + 1)


class Tetrominoes(object):
    NoShape = 0
    ZShape = 1
    SShape = 2
    LineShape = 3
    TShape = 4
    SquareShape = 5
    LShape = 6
    MirroredLShape = 7


class Shape(object):
    coordsTable = (
        ((0, 0),     (0, 0),     (0, 0),     (0, 0)),
        ((0, -1),    (0, 0),     (-1, 0),    (-1, 1)),
        ((0, -1),    (0, 0),     (1, 0),     (1, 1)),
        ((0, -1),    (0, 0),     (0, 1),     (0, 2)),
        ((-1, 0),    (0, 0),     (1, 0),     (0, 1)),
        ((0, 0),     (1, 0),     (0, 1),     (1, 1)),
        ((-1, -1),   (0, -1),    (0, 0),     (0, 1)),
        ((1, -1),    (0, -1),    (0, 0),     (0, 1))
    )

    def __init__(self):
        self.coords = [[0,0] for i in range(4)]
        self.pieceShape = Tetrominoes.NoShape
        self.setShape(Tetrominoes.NoShape)

    def shape(self):
        return self.pieceShape

    def setShape(self, shape):
        table = Shape.coordsTable[shape]
        for i in range(4):
            for j in range(2):
                self.coords[i][j] = table[i][j]
        self.pieceShape = shape

    def setRandomShape(self):
        self.setShape(random.randint(1, 7))

    def x(self, index):
        return self.coords[index][0]

    def y(self, index):
        return self.coords[index][1]

    def setX(self, index, x):
        self.coords[index][0] = x

    def setY(self, index, y):
        self.coords[index][1] = y

    def minX(self):
        m = self.coords[0][0]
        for i in range(4):
            m = min(m, self.coords[i][0])
        return m

    def maxX(self):
        m = self.coords[0][0]
        for i in range(4):
            m = max(m, self.coords[i][0])
        return m

    def minY(self):
        m = self.coords[0][1]
        for i in range(4):
            m = min(m, self.coords[i][1])
        return m

    def maxY(self):
        m = self.coords[0][1]
        for i in range(4):
            m = max(m, self.coords[i][1])
        return m

    def rotatedLeft(self):
        if self.pieceShape == Tetrominoes.SquareShape:
            return self
        result = Shape()
        result.pieceShape = self.pieceShape
        for i in range(4):
            result.setX(i, self.y(i))
            result.setY(i, -self.x(i))
        return result

    def rotatedRight(self):
        if self.pieceShape == Tetrominoes.SquareShape:
            return self
        result = Shape()
        result.pieceShape = self.pieceShape
        for i in range(4):
            result.setX(i, -self.y(i))
            result.setY(i, self.x(i))
        return result


app = QtGui.QApplication(sys.argv)
tetris = Tetris()
tetris.show()
# 在 PyQt 4.5 與 Python3 環境下可以直接使用 exec() 但是也可以使用舊版的 exec_()
#sys.exit(app.exec_())
c.my_test = tetris</t>
<t tx="amd.20150318155833.40">def getInput (event=None):

   stateName = 'get-input'
   k = c.k
   state = k.getState(stateName)

   if state == 0:
       k.setLabelBlue('輸入為: ')
       k.getArg(event,stateName,1,getInput)
   else:
       k.clearState()
       g.es_print('你的輸入為: %s' % k.arg)

getInput()</t>
<t tx="amd.20150318155833.41">@language python
#coding: utf-8
import xmlrpc.client
import datetime
import os
os.environ['TZ'] = 'Asia/Taipei'
 
wp_url = "https://demo-2015course.rhcloud.com/xmlrpc.php"
wp_username = "帳號"
wp_password = "密碼"
wp_blogid = "0"
 
status_draft = 0
status_published = 1
 
server = xmlrpc.client.ServerProxy(wp_url)
 
title = str(datetime.datetime.now())+"測試是否可以現在時間上傳網誌, 再試一次"
content = '''這是以 Python 程式新增的網誌內容!
並且進行跳行
前面這裡跳行.&lt;!--more--&gt;'''
content +='''[python]'''
content +='''
#coding: utf-8
import xmlrpc.client
import datetime
import os
os.environ['TZ'] = 'Asia/Taipei'
for 索引 in range(10):
    print("測試")
'''
content +="[/python]"
# 指定時間出版
'''
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime("2013-01-01 00:00",
"%Y-%m-%d %H:%M"))
'''
# 以現在時間出版, 考慮與 Server 時間差八個小時 (480 分鐘), 因此要在 8 個小時前發表
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime((datetime.datetime.now()- \
datetime.timedelta(minutes=480)).strftime('%Y-%m-%d %H:%M'),"%Y-%m-%d %H:%M"))
categories = ["Uncategorized"]
tags = ["python", "測試"]
data = {'title': title, 'description': content, 'dateCreated': date_created, 'categories': categories, 'mt_keywords': tags}
 
post_id = server.metaWeblog.newPost(wp_blogid, wp_username, wp_password, data, status_published)
g.es("post_id 為", post_id)
g.es("已經送出資料!")
'''
其他 metaWeblog 的用法:
metaWeblog.newPost (blogid, username, password, struct, publish) returns string(postid)
metaWeblog.editPost (postid, username, password, struct, publish) returns true
metaWeblog.getPost (postid, username, password) returns struct(blog content)
'''</t>
<t tx="amd.20150318155833.42">送出資料後, 取得 post_id 存在特定的 children 節點上, 然後隨後的編輯更動將依此 post_id 擷取資料?
帳號密碼可以使用 query 的方式, 在送出或編輯資料時, 由使用者輸入</t>
<t tx="amd.20150318155833.44"></t>
<t tx="amd.20150318155833.45">QSplitter::handle {
    background-color: #CAE1FF; /* lightSteelBlue1 */
}

QStackedWidget {
    /* background-color:lightpink; */
    border-color: red;
    padding: 0px;
    /* border-width: 0px; */
    /* background-color: yellow; */
}

QSplitter {
    border-color: white;
    background-color: white;
    border-style: solid;
}

QTreeWidget {
    /* These apply to the selected item, but not to editing items.*/
    background-color: #ffffec; /* Leo's traditional tree color */
    selection-color: black; /* was white */
    selection-background-color: lightgrey;
    /* font-family: SansSerif; */
    /*font-family: DejaVu Sans Mono;*/
    font-family:YaHei Mono;
    /* 標題字型大小設定 */
    font-size: 22px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
 }

/* Headline edit widgets */
QTreeWidget QLineEdit {
    background-color: cornsilk;
    selection-color: white;
    selection-background-color: blue;
    /*font-family: DejaVu Sans Mono;*/    
    font-family:YaHei Mono;
    /* 沒有特別對應字型大小 */
    font-size: 22px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The log panes */
QTextEdit {
    background-color: #f2fdff;
    selection-color: red;
    selection-background-color: blue;
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* log font 大小 */
    font-size: 22px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal, italic,oblique */
}

/* The body pane */
QTextEdit#richTextEdit {
    background-color: #fdf5f5; /* A kind of pink. */
    selection-color: white;
    selection-background-color: red;
    /*font-family: DejaVu Sans Mono;*/
    /* font-family: Courier New; */
    font-family:YaHei Mono;
    /* 內文字型大小 */
    font-size: 22px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

QLabel {
    font-family:YaHei Mono;
    /* 下方的 Minibuffer 標題字型大小 */
    font-size: 22px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
}

/* Editor labels */
QLineEdit#editorLabel {
    background-color: #ffffec;
    font-family:YaHei Mono;
    /* 沒有直接對應字型大小 */
    font-size: 22px;
    font-weight: normal; /* normal,bold,100,..,900 */
    font-style: normal; /* normal,italic,oblique */
    border: 2px;
    margin: 2px;
}</t>
<t tx="amd.20150318155833.46">horizontal: body pane to the left
vertical: body pane on the botton</t>
<t tx="amd.20150318155833.47"></t>
<t tx="amd.20150318155833.49">@language python
#coding: utf-8
import xmlrpc.client
import datetime
import os

def get_cat_tag_content(data):
    data_list = data.split("\n")
    # 只有一項資料的 category 型別為字串
    category = data_list[0]
    # 只有一項資料的 tags 型別為字串
    tags = data_list[1]
    # 有多項資料的 content 型別為數列
    # 再將第3行之後的資料數列串回成以跳行隔開的資料
    content = "\n".join(data_list[2:])
    return category, tags, content
    
os.environ['TZ'] = 'Asia/Taipei'

#################################
# Open a file
fo = open(p.parent().b, "r+")
data = []
for line in fo.readlines():
    data.append(line)
    #print(line)
#print(data[0])
 
# Close opend file
fo.close()
 
# 從網誌節點的 parent().h 取得 wp_url
# 從網誌節點的 parent().b 取得帳號與密碼對應的文字檔案路徑
wp_url = "https://"+p.parent().h+"/xmlrpc.php"
wp_username = data[0]
wp_password = data[1]
#################################
wp_blogid = "0"
 
status_draft = 0
status_published = 1
 
server = xmlrpc.client.ServerProxy(wp_url)
 
title = p.h
#content = p.b
category_str, tags_str, content = get_cat_tag_content(p.b)
# 指定時間出版
'''
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime("2013-01-01 00:00",
"%Y-%m-%d %H:%M"))
'''
# 以現在時間出版, 考慮與 Server 時間差八個小時 (480 分鐘), 因此要在 8 個小時前發表
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime((datetime.datetime.now()- \
datetime.timedelta(minutes=480)).strftime('%Y-%m-%d %H:%M'),"%Y-%m-%d %H:%M"))
#categories = ["Uncategorized"]
#tags = ["python", "測試"]
categories = [category_str.split(":")[1]]
# 請注意, 因為 tags 用逗點隔開, 因此必須透過 split() 再分開成為 list 資料
tags = tags_str.split(":")[1].split(",")
data = {'title': title, 'description': content, 'dateCreated': date_created, 'categories': categories, 'mt_keywords': tags}
 
post_id = server.metaWeblog.newPost(wp_blogid, wp_username, wp_password, data, status_published)
# 利用最後的 child 節點來儲存 post_id
to_save_post_id = p.insertAsLastChild()    
to_save_post_id.b = post_id
to_save_post_id.h = "文章 id"
# 因為新增節點, commander 必須 redraw
c.redraw() 

g.es("post_id 為", post_id)
g.es("已經送出資料!")
'''
其他 metaWeblog 的用法:
metaWeblog.newPost (blogid, username, password, struct, publish) returns string(postid)
metaWeblog.editPost (postid, username, password, struct, publish) returns true
metaWeblog.getPost (postid, username, password) returns struct(blog content)
'''</t>
<t tx="amd.20150318155833.50">category:Uncategorized
tags:python, 測試
這是第1週的摘要內容
[python]
for i in range(5):
    可以 = 5
    print (i,":",可以)
[/python]
這個程式的真正用途說明
這筆資料從 Leo Editor 送出.
這是更新的資料, 沒有錯</t>
<t tx="amd.20150318155833.51">'''在目前所選節點位置, 為 p, 執行
insertAsLastChild(), 且隨後宣告其
標題與內文'''
child = p.insertAsLastChild()    
child.b = "我的內文"
child.h = "我的標題"
'''將目前所選節點位置中, 取最後一個 Child, 然後對應給 added 變數
這樣就可以取得 added 的標題與內文'''
added = p.getLastChild()
g.es("標題:"+added.h+"內文:"+added.b)

c.redraw() </t>
<t tx="amd.20150319203708.45">http://leo-editor.readthedocs.org/en/latest/leo.core.html?highlight=insertaslastchild#leo.core.leoNodes.Position.insertAsLastChild</t>
<t tx="amd.20150319203708.48">@language python
#coding: utf-8
import xmlrpc.client
import datetime
import os

def get_cat_tag_content(data):
    data_list = data.split("\n")
    # 只有一項資料的 category 型別為字串
    category = data_list[0]
    # 只有一項資料的 tags 型別為字串
    tags = data_list[1]
    # 有多項資料的 content 型別為數列
    # 再將第3行之後的資料數列串回成以跳行隔開的資料
    content = "\n".join(data_list[2:])
    return category, tags, content
    
os.environ['TZ'] = 'Asia/Taipei'
 
#################################
# Open a file
fo = open(p.parent().b, "r+")
data = []
for line in fo.readlines():
    data.append(line)
    #print(line)
#print(data[0])
 
# Close opend file
fo.close()

# 從網誌節點的 parent().h 取得 wp_url
# 從網誌節點的 parent().b 取得帳號與密碼對應的文字檔案路徑
wp_url = "https://"+p.parent().h+"/xmlrpc.php"
wp_username = data[0]
wp_password = data[1]
#################################
wp_blogid = "0"
 
status_draft = 0
status_published = 1
 
server = xmlrpc.client.ServerProxy(wp_url)
 
title = p.h
#content = p.b
category_str, tags_str, content = get_cat_tag_content(p.b)
# 指定時間出版
'''
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime("2013-01-01 00:00",
"%Y-%m-%d %H:%M"))
'''
# 以現在時間出版, 考慮與 Server 時間差八個小時 (480 分鐘), 因此要在 8 個小時前發表
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime((datetime.datetime.now()- \
datetime.timedelta(minutes=480)).strftime('%Y-%m-%d %H:%M'),"%Y-%m-%d %H:%M"))
#categories = ["Uncategorized"]
#tags = ["python", "測試"]
categories = [category_str.split(":")[1]]
# 請注意, 因為 tags 用逗點隔開, 因此必須透過 split() 再分開成為 list 資料
tags = tags_str.split(":")[1].split(",")
data = {'title': title, 'description': content, 'dateCreated': date_created, 'categories': categories, 'mt_keywords': tags}

# 設法取得原 post 的 id
origin_post = p.getLastChild()
post_id = origin_post.b
status = server.metaWeblog.editPost(post_id, wp_username, wp_password, data, status_published)

if status:
    g.es("資料已經更新!")
else:
    g.es("有問題, 資料沒有更新!")
'''
其他 metaWeblog 的用法:
metaWeblog.newPost (blogid, username, password, struct, publish) returns string(postid)
metaWeblog.editPost (postid, username, password, struct, publish) returns true
metaWeblog.getPost (postid, username, password) returns struct(blog content)
'''</t>
<t tx="amd.20150319203708.49">category:Uncategorized
tags:python, 測試
在第2週, 除了利用 OpenShift 安裝 Wordpress 4 之外, 還學習如何
&lt;!--more--&gt;
讓同組學員成為 author.</t>
<t tx="amd.20150320090250.40"># 改為讀檔案取得網誌連結, 帳號與密碼
# Open a file
fo = open("foo.txt", "r+")
'''
foo.txt 內容
 
https://網誌網址/xmlrpc.php
 
帳號
密碼
'''
data = []
for line in fo.readlines():
    data.append(line)
    #print(line)
#print(data[0])
 
# Close opend file
fo.close()
 
wp_url = data[0]
wp_username = data[1]
wp_password = data[2]</t>
<t tx="amd.20150320090250.42">/home/amd/Desktop/demo-2015course.txt</t>
<t tx="amd.20150320090250.45">首節點標題為 Wordpress site 的 domain name, 程式會加上 https:// 頭與 /xmlrpc.php 尾

首節點對應的 body 內容為儲存發佈訊息的帳號密碼檔案的存放路徑

新增 post 結束後, 程式會在訊息發佈節點的下屬, 新增一個"文章 id" 內文存放該對應內容的 post_id, 當 post 對應節點內容更動後, 就是透過此一 id 執行資料更新

將 new-to-wp 與 edit-to-wp 設為 buttons

記得在 WP 新增一個 author 帳號, 以便與 Leo Editor 中的 buttons 程式配合, 不要使用 site administrator 帳號.

為了配合網誌更新流程中, 使用者在瀏覽器中更新既有的網誌文章, 然後再透過 Leo Editor 對應專案進行改版, 此時使用者必須先從網誌取下特定文章的內容之後, 才能根據最新文章加以改版. 換言之, 這裡需要一個 update-from-wp 透過"文章 id" 取下文章的最新內容, 而非使用 Leo Editor 中的舊內容進行改版.</t>
<t tx="amd.20150320090250.46">/home/amd/Desktop/wordpress-chiamingyen.txt</t>
<t tx="amd.20150320090250.47">/home/amd/Desktop/wordpress-2015course.txt</t>
<t tx="amd.20150321081347.40">@language python
'''
for p in c.all_positions():
    # 列出所有節點的 level() 與 h
    # 第1層 p.level() 為 0, h 為節點標題
    g.es(p.level(), p.h)
'''
'''
# echo string 時, 利用 angleBrackets 圈住字串
g.es(g.angleBrackets('abc'))
# 若節點內容或架構更動, 需要利用 c.redraw() 重新繪製
c.redraw_now()
'''
# 有關 generator
'''
A generator is simply a function which returns an object on which you can call next, such that for every call it returns some value, until it raises a StopIteration exception, signaling that all values have been generated. Such an object is called an iterator.

Normal functions return a single value using return, just like in Java. In Python, however, there is an alternative, called yield. Using yield anywhere in a function makes it a generator.
'''
# 利用 yield 傳值以便定義 generator 函式
def myGen(n):
    yield n
    yield n + 1
data = myGen(6)
g.es(next(data))
g.es(next(data))

# 若再呼叫 next(data) 就會出錯, 因為 yield 只有兩筆</t>
<t tx="amd.20150321081347.44">212</t>
<t tx="amd.20150321081347.45">215</t>
<t tx="amd.20150321081347.46">category:文章類別
tags:標籤用逗點隔開
第3行開始就是文章內容

目前的 categories 有 Leo Editor, Brython, Docker 與 Uncategorized</t>
<t tx="amd.20150321081347.47">category:文章類別
tags:標籤用逗點隔開
第3行開始就是文章內容

目前的 categories 有:

2015 協同產品設計實習(教材專用)

2015 網際內容管理(教材專用)

網路文摘

用戶故事

    機械設計工程系

    計算機程式

    設計運算

議題討論

與 Uncategorized</t>
<t tx="amd.20150321081347.48">category:Leo Editor
tags:資料管理
Leo Editor 對於已經熟悉 Python 的使用者來說, 可以是一項如虎添翼的資料管理工具. 這裡我們將利用 Leo Editor 來管理雲端 Wordpress 網誌上的文章.

&lt;!--more--&gt;

&lt;a href="http://leoeditor.com/"&gt;http://leoeditor.com/&lt;/a&gt;

在 Leo Editor 節點中, 用來產生 new-to-wp 按鈕的程式碼:
[python]
@language python
#coding: utf-8
import xmlrpc.client
import datetime
import os

def get_cat_tag_content(data):
    data_list = data.split("\n")
    # 只有一項資料的 category 型別為字串
    category = data_list[0]
    # 只有一項資料的 tags 型別為字串
    tags = data_list[1]
    # 有多項資料的 content 型別為數列
    # 再將第3行之後的資料數列串回成以跳行隔開的資料
    content = "\n".join(data_list[2:])
    return category, tags, content
    
os.environ['TZ'] = 'Asia/Taipei'

#################################
# Open a file
fo = open(p.parent().b, "r+")
data = []
for line in fo.readlines():
    data.append(line)
    #print(line)
#print(data[0])
 
# Close opend file
fo.close()
 
# 從網誌節點的 parent().h 取得 wp_url
# 從網誌節點的 parent().b 取得帳號與密碼對應的文字檔案路徑
wp_url = "https://"+p.parent().h+"/xmlrpc.php"
wp_username = data[0]
wp_password = data[1]
#################################
wp_blogid = "0"
 
status_draft = 0
status_published = 1
 
server = xmlrpc.client.ServerProxy(wp_url)
 
title = p.h
#content = p.b
category_str, tags_str, content = get_cat_tag_content(p.b)
# 指定時間出版
'''
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime("2013-01-01 00:00",
"%Y-%m-%d %H:%M"))
'''
# 以現在時間出版, 考慮與 Server 時間差八個小時 (480 分鐘), 因此要在 8 個小時前發表
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime((datetime.datetime.now()- \
datetime.timedelta(minutes=480)).strftime('%Y-%m-%d %H:%M'),"%Y-%m-%d %H:%M"))
#categories = ["Uncategorized"]
#tags = ["python", "測試"]
categories = [category_str.split(":")[1]]
tags = [tags_str.split(":")[1]]
data = {'title': title, 'description': content, 'dateCreated': date_created, 'categories': categories, 'mt_keywords': tags}
 
post_id = server.metaWeblog.newPost(wp_blogid, wp_username, wp_password, data, status_published)
# 利用最後的 child 節點來儲存 post_id
to_save_post_id = p.insertAsLastChild()    
to_save_post_id.b = post_id
to_save_post_id.h = "文章 id"
# 因為新增節點, commander 必須 redraw
c.redraw() 

g.es("post_id 為", post_id)
g.es("已經送出資料!")
'''
其他 metaWeblog 的用法:
metaWeblog.newPost (blogid, username, password, struct, publish) returns string(postid)
metaWeblog.editPost (postid, username, password, struct, publish) returns true
metaWeblog.getPost (postid, username, password) returns struct(blog content)
'''
[/python]
用來產生 edit-to-wp 按鈕的程式碼:
[python]
@language python
#coding: utf-8
import xmlrpc.client
import datetime
import os

def get_cat_tag_content(data):
    data_list = data.split("\n")
    # 只有一項資料的 category 型別為字串
    category = data_list[0]
    # 只有一項資料的 tags 型別為字串
    tags = data_list[1]
    # 有多項資料的 content 型別為數列
    # 再將第3行之後的資料數列串回成以跳行隔開的資料
    content = "\n".join(data_list[2:])
    return category, tags, content
    
os.environ['TZ'] = 'Asia/Taipei'
 
#################################
# Open a file
fo = open(p.parent().b, "r+")
data = []
for line in fo.readlines():
    data.append(line)
    #print(line)
#print(data[0])
 
# Close opend file
fo.close()

# 從網誌節點的 parent().h 取得 wp_url
# 從網誌節點的 parent().b 取得帳號與密碼對應的文字檔案路徑
wp_url = "https://"+p.parent().h+"/xmlrpc.php"
wp_username = data[0]
wp_password = data[1]
#################################
wp_blogid = "0"
 
status_draft = 0
status_published = 1
 
server = xmlrpc.client.ServerProxy(wp_url)
 
title = p.h
#content = p.b
category_str, tags_str, content = get_cat_tag_content(p.b)
# 指定時間出版
'''
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime("2013-01-01 00:00",
"%Y-%m-%d %H:%M"))
'''
# 以現在時間出版, 考慮與 Server 時間差八個小時 (480 分鐘), 因此要在 8 個小時前發表
date_created = xmlrpc.client.DateTime(datetime.datetime.strptime((datetime.datetime.now()- \
datetime.timedelta(minutes=480)).strftime('%Y-%m-%d %H:%M'),"%Y-%m-%d %H:%M"))
#categories = ["Uncategorized"]
#tags = ["python", "測試"]
categories = [category_str.split(":")[1]]
tags = [tags_str.split(":")[1]]
data = {'title': title, 'description': content, 'dateCreated': date_created, 'categories': categories, 'mt_keywords': tags}

# 設法取得原 post 的 id
origin_post = p.getLastChild()
post_id = origin_post.b
status = server.metaWeblog.editPost(post_id, wp_username, wp_password, data, status_published)

if status:
    g.es("資料已經更新!")
else:
    g.es("有問題, 資料沒有更新!")
'''
其他 metaWeblog 的用法:
metaWeblog.newPost (blogid, username, password, struct, publish) returns string(postid)
metaWeblog.editPost (postid, username, password, struct, publish) returns true
metaWeblog.getPost (postid, username, password) returns struct(blog content)
'''
[/python]

基本規劃如下:
    建立一個節點, 標題為 Wordpress 網誌的網址, 例如: wordpress-chiamingyen.rhcloud.com
    而此節點的內容則為發佈網誌者的帳號與密碼所在的檔案位置, 例如: /home/amd/Desktop/wordpress-chiamingyen.txt
    而此 wordpress-chiamingyen.txt 檔案內容, 共有兩行, 第1行為發佈者的帳號, 而第2行則為密碼.
    
而在 Leo Editor Wordpress 網誌節點下屬, 則為所要發佈的網誌內容節點, 標題為網誌主題, 而內容格式則為:
    category:文章類別
    tags:標籤用逗點隔開
    第3行開始就是文章內容
    
而發佈資料時, 只要滑鼠選擇已經寫好的網誌內容節點標題, 然後按下 new-to-wp, 程式就會自動讀取所需的發佈者帳號與密碼, 並且解析文章內容中的第1行與第2行, 取得所要發佈的類別與標籤, 且確定發佈內容後, 就會將資料送到對應的網誌, 然後在子節點記下登記的 post_id, 隨後若需要編輯修改此一網誌內容, 將會依賴此一 post_id 更新資料.

當某一網誌內容發佈後, 若內容需要更新, 則同樣選擇更新後的網誌節點, 然後按下 edit-to-wp 按鈕就可以完成更新.</t>
<t tx="amd.20150321081347.49">4</t>
<t tx="amd.20150322185151.11">category:2015 網際內容管理(教材專用)
tags:課前準備, EasyWPGuide

Welcome:

My aim is to create a simple WordPress guide that will help you to get an overall understanding of how you use the various features within the WordPress Dashboard to keep your site or blog updated.

若想要獲得更深入的資料: &lt;a href="http://codex.wordpress.org/Main_Page"&gt;http://codex.wordpress.org/Main_Page&lt;/a&gt;

&lt;!--more--&gt;

Introduction:

WordPress is an Open Source software system used by millions of people around the world to create beautiful websites and blogs. It is completely customisable by the use of themes and plugins.

WordPress powers a staggering (so surprisingly impressive as to stun or overwhelm) amount of websites. In fact, it powers over 23% of the whole web! Everything from personal blogs to large corporate websites.

Before you can make any changes to your site, you will need to log in. The login for your site is typically found at the following URL - http://your-wordpress-site.com/wp-admin.

Once you’ve logged in, the WordPress Dashboard appears. This is your main administration homepage.

The Screen Options link will display various options that allow you to configure what is displayed on the current page.

WordPress is built around two basic concepts. Posts and Pages. Posts are typically blog entries. A series of articles, listed (usually) reverse-chronologically. Pages are used for more static content (i.e. content that doesn’t change or changes infrequently). An ‘About us’ page is an example of a Page on a typical website. In
most cases you’ll find that the content in the ‘About us’ page doesn’t change all that frequently.

Posts allow you to associate Categories and Tags whereas Pages don’t. What’s the difference between categories and tags? Normally, Tags are ad-hoc keywords that identify important information in your Post (names, subjects, etc) that may or may not recur in other Posts, while Categories are pre-determined sections. If you think of your site like a book, the Categories are like the Table of Contents and the Tags are like the terms in the index.

A Post Format is meta information that can be used within a Theme to style or customise the presentation of a Post. The Post Formats feature provides a standardised list of formats that are available to all themes that support the feature. There is no requirement for Themes to support every format on the list and new formats cannot be introduced by themes or even plugins. If your Theme supports Post Formats you can choose how each Post looks by selecting a Post Format from a list of radio buttons, similar to the following screen. If your Theme doesn’t support Post Formats then the Format panel won’t be displayed.

Widgets are independent sections of content that can be placed into any widgetized area provided by your theme. Although these widgetized areas are commonly called ‘Sidebars’ and are quite often located in the left or right-hand column, they can be also located anywhere within your site and are entirely dependent on the current theme as to their location. Lots of themes use these widgetized sidebars in the footer area.

Plugins extend and expand the functionality of WordPress. Once a plugin is installed, you may activate it or deactivate it here.

Users with roles other than Administrator will see fewer options when they are logged in. Depending on your
Role, you can also add new users as well as manage their Roles.

• Administrator – Somebody who has access to all the administration features
• Editor – Somebody who can publish and manage posts and pages as well as
manage other users' posts, etc.
• Author – Somebody who can publish and manage their own posts
• Contributor – Somebody who can write and manage their posts but not
publish them
• Subscriber – Somebody who can only manage their profile

中文支援論壇: &lt;a href="http://tw.forums.wordpress.org/"&gt;http://tw.forums.wordpress.org/&lt;/a&gt;</t>
<t tx="amd.20150322185151.12">627</t>
<t tx="amd.20150322185151.13">category:2015 協同產品設計實習(教材專用)
tags:課前準備, Scrum, 機械設計
先消化這一份資料: &lt;a href="http://www.delightpress.com.tw/bookRead/skna00001_read.pdf"&gt;Scrum 是很有內涵的&lt;/a&gt;

Abstract

The purpose of this study was to investigate if it would be possible for a mechanical product development team to use Scrum, an Agile Development framework.

The results indicate that it is possible for a mechanical development team to use the Scrum framework, with some minor adaptions of the framework. The team in the primary case made use of all main aspects of the framework, but the deviations were that the team was not cross-functional and a working product or product increment is not produced every iteration. The results also indicate that using the framework improved the team’s work and progress, and the team decided to continue using the framework after the experiment.

&lt;!--more--&gt;

Introduction

New product development is a complex endeavour, which can often be difficult to handle and challenging to see in advance what the end result will be. There is great uncertainty and unexpected things happen along the way, which affects the scope and direction of a product development project. Therefore these projects can often be difficult to plan, and plans become obsolete soon after their creation.

Agile Software Development became a collective term for the new methods, which are all based on iterative and incremental development of self-organizing cross-functional teams, rapidly responding to change.

Estimates are shared in Agile teams; they are not made by a single individual on the team, or a single expert. As the whole team will do the work, all team members make the estimates.

Work items are often called a User Story or a Story, and the estimates used to express an overall story’s size are often called Story Points.

Scrum is not a process or a technique for building products; rather, it is a framework within which you can employ various processes and techniques. Scrum makes clear the relative efficacy of your product management and development practices so that you can improve.

Scrum is founded on empirical process control theory, or empiricism. Empiricism asserts that knowledge comes from experience and making decisions based on what is known. Scrum employs an iterative, incremental approach to optimize predictability and control risk.

There are three roles in Scrum, the Project Owner, the Scrum Master and the Team. Together these three roles form the Scrum Team. The Product Owner is the person that is financially responsible of the product. That person prioritizes items according to the needs of the product and the stakeholders. The Scrum Master is a person with experience in Scrum and he or she supports the Product Owner and the Team in complying with the Scrum rules. The Scrum Master also protects the team from external interruption, in order for the team to be focused on their work. The Team is a group of approximately seven people that executes the prioritized tasks and develops the final product.

The development work is performed in cycles called Sprints. Each Sprint can be from 1 to 4 weeks long, and are iterated without a pause. At the start of a Sprint the team commits to what work items they will complete by the end of the upcoming Sprint. The team chooses from a list of items, called the Product Backlog that has been prioritized by the Product Owner. This prioritization is based on input from all stakeholders of the product. When a Sprint has started, no changes can be made to the committed task list, nor can the Sprint be elongated. The Sprint will finish on a set date whether or not the Team has completed what it had committed to.

During a Sprint a 15-minute Daily Meetings are held. This is a way for the team members to communicate to each other what their status is. Each team member communicates the following; what they have done since the last meeting, what they are going to do now, and if there are any impediments in their way. This allows other members to offer their help, but further discussions about the details will continue after the Daily Meeting. All other technical or more detailed discussion can be taken up after the meeting.

An important part of Scrum is “inspect and adapt”. At the end of a Sprint, a Sprint Review is held that focuses on the product. One part of the Review is a demonstration of the finished product part to all stakeholders. However, the main purpose of the Review is an in depth conversation about the product between the Team members and the Product Owner, on the status as well as getting advice. Another meeting is held at the end of a Sprint, called Retrospective meeting. This meeting focuses on the inspecting and adapting the process and is facilitated by the Scrum Master. There the Team can identify how the process can be improved.

Adaptations to the Framework

When asked what adaptations mechanical teams might need to make in order to use the framework the SM listed the following items:

•Variable Sprint lengths might be needed in order to accommodate for e.g. field test.
•That User Stories are not used. It might not be possible to base definition of stories or work tasks might on the user experience.

She stated that otherwise, the teams should be able to use the other elements of the framework, such as Daily stand-ups, have a backlog, and do planning and tasking stories as well as use relative estimating. She noted that the mechanical team had been sceptic about relative estimating and Planning Poker but that it worked well for them and they were using it. The SM stated that relative estimating is very helpful and the benefit is that it is so quick, and afterwards it is possible to easily calculate the cost of each point.

Advantages

The team was asked to name three or more advantages of the new work system. The answers were grouped into the following categories:

• Daily Stand-up: Three team members noted that the Daily meetings were an advantage, and noted that the meetings create discussions and the problems become clearer as they are discussed daily.
• Functional breakdown: One team member mentioned work breakdown as positive, and was most likely referring to the breakdown that was done at the Release Planning meeting, where the machines was broken down into sub-systems and components.
• Overview and clarity: Three team members mentioned that the work system gives a clearer overview of the project and its status.
• Plan: One team member mentioned that it was positive that there was some kind of a plan.
• Communication and Co-operation: Three team member noted positive elements in regards to communication and co-operation. It was mentioned that now the team is a whole, single entity and everyone has a chance to give feedback on tasks that others are working on. The work system supports knowledge transfer and creates a forum for discussions.
•Focus: One team member mentioned that the system has provided focus for the team, as other projects are dismissed to keep the team focused.

參考資料: 
&lt;a href="http://www.slideshare.net/teddysoft/10published?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;軟體開法成功秘訣&lt;/a&gt;
&lt;a href="http://www.slideshare.net/teddysoft/pub-43056568?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;敏捷開發精神介紹&lt;/a&gt;
&lt;a href="http://www.slideshare.net/teddysoft/pattern-design-patterns-20published?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;那一夜我們說 Pattern&lt;/a&gt;
&lt;a href="http://www.slideshare.net/teddysoft/design-pattern-day1201307published?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;Design Pattern 第1堂課&lt;/a&gt;
&lt;a href="http://www.slideshare.net/teddysoft/ss-35192183?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;Scrum 導入經驗分享&lt;/a&gt;
&lt;a href="http://www.slideshare.net/teddysoft/30-14340071?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;Pattern 入門&lt;/a&gt;
&lt;a href="http://www.slideshare.net/ZongYingLyu/scrum-41408111?qid=f3dd0949-54ed-4215-8451-25381fbba533"&gt;Scrum!&lt;/a&gt;
&lt;a href="http://publications.lib.chalmers.se/records/fulltext/191951/191951.pdf"&gt;Scrum in Mechanical Product Development(論文)&lt;/a&gt;
&lt;a href="http://www.books.com.tw/products/0010549884"&gt;陳建村-笑談軟體工程：敏捷開發法的逆襲&lt;/a&gt;

</t>
<t tx="amd.20150322185151.14">630</t>
<t tx="amd.20150323191758.4">category:2015 協同產品設計實習(教材專用)
tags:課前準備, Scrum, 機械設計
這是一個包含 scrumaster, product-owner, scrum-1, scrum-2, scrum-3, scrum-4 等六位組員的協同產品開發團隊, 目前希望能夠在 4/8 之前完成專案一.

&lt;!--more--&gt;

專案一:

正齒輪減速機零件設計繪圖服務系統：

使用者利用瀏覽器連結至各組的 2D 正齒輪繪圖系統, 系統提供齒數, 模數與壓力角等3個欄位, 使用者根據使用說明, 填入所需設計參數後送出表單, 系統繪出符合規格之 2D 正齒輪輪廓圖.

使用者利用瀏覽器連結至各組的 3D 正齒輪繪圖系統, 系統提供齒數, 模數與壓力角等3個欄位, 使用者根據使用說明, 準備好近端的 Creo 系統環境後, 填入所需設計參數後送出表單, 系統繪出符合規格之 3D 正齒輪零件, 並將零件檔案存入近端目錄中.

&lt;hr&gt;

以下開始本組的專案一執行.

stories:

故事一: 需要有組員交換意見的平台

提供一個讓各組員可以回報執行進度, 可以線上開會,  可以針對開會主題進行意見交換或討論的平台或機制.

故事二: 協同過程中,  各組員可以同步或非同步彙整所完成的資料

當組員可以直接在線上開會, 交付報告後, 能夠有一個機制或方法, 可以讓各組員將所完成的資料或程式進行版次管理, 不僅可以完成保留各組員各階段所完成的所有資料, 而且這些資料能夠與最終的 pdf 報告或 html 格式報告, 或者雲端網站資料整合在一起.

故事三: 完成 2D 正齒輪繪圖系統

使用者利用瀏覽器連結至各組的 2D 正齒輪繪圖系統, 系統提供齒數, 模數與壓力角等3個欄位, 使用者根據使用說明, 填入所需設計參數後送出表單, 系統繪出符合規格之 2D 正齒輪輪廓圖.

故事四: 完成 3D 正齒輪繪圖系統

使用者利用瀏覽器連結至各組的 3D 正齒輪繪圖系統, 系統提供齒數, 模數與壓力角等3個欄位, 使用者根據使用說明, 準備好近端的 Creo 系統環境後, 填入所需設計參數後送出表單, 系統繪出符合規格之 3D 正齒輪零件, 並將零件檔案存入近端目錄中.

接下來, 本組將針對上述四個故事, 提出工作清單, 預估完成所需時間, 任務分配表, 以及定義所要交付的成果等.

配合上述規劃分別完成下列設定:

Wordperss 網誌: &lt;a href="https://wordpress-productownermde.rhcloud.com"&gt;https://wordpress-productownermde.rhcloud.com&lt;/a&gt;

Github 倉儲: &lt;a href="https://github.com/product-owner/2015scrum"&gt;https://github.com/product-owner/2015scrum&lt;/a&gt;

與 2015scrum 倉儲對應的專案管理系統: &lt;a href="https://waffle.io/product-owner/2015scrum"&gt;https://waffle.io/product-owner/2015scrum&lt;/a&gt;

Gitbook 電子書閱讀: &lt;a href="http://product_owner.gitbooks.io/2015scrumproject/content"&gt;http://product_owner.gitbooks.io/2015scrumproject/content&lt;/a&gt;</t>
<t tx="amd.20150323191758.5">使用 Windows 進行"new-to-wp" button 新增資料時, 會出現資料編碼上的問題.

可能原因:

read 或 write 時沒有宣告資料的 encoding.

處理與測試:</t>
<t tx="amd.20150323191758.6">665</t>
<t tx="amd.20150323191758.7">Product Owner:

    product_owner@mde.tw
    
    sign up OpenShift account and create https://wordpress-productownermde.rhcloud.com
    
    on Github as product-owner and create https://github.com/product-owner/2015scrum
    
    2015scrum repository is synchronized to https://waffle.io/product-owner/2015scrum
    
    sign up Disqus account as product_owner - shortname is 2015scrumproject
    
    sign up Gitbook as product_owner create http://product_owner.gitbooks.io/2015scrumproject/content/

Scrum Master:

    scrumaster@mde.tw
    
    on Github as scrumaster
    
    sign up Gitbook as product_owner and create an ebook: 


Developers:

    scrum1@mde.tw
    
        on Github as scrum-1
        
    scrum2@mde.tw
    
        on Github as scrum-2
    
    scrum3@mde.tw
        
        on Github as scrum-3
        
    scrum4@mde.tw

    on Github as scrum-4</t>
<t tx="amd.20150326092950.3">http://wordpress-chiamingyen.rhcloud.com

使用 @url 的方法為:

左手按住 ctrl, 右手滑鼠選擇 @url node 標題, 然後點擊右鍵</t>
<t tx="amd.20150326093802.57">category:Docker
tags:虛擬技術
&lt;a href="http://segmentfault.com/a/1190000000366923"&gt;Docker 簡介&lt;/a&gt;

2014.06 起 &lt;a href="http://www.codedata.com.tw/social-coding/docker-layman-abc/"&gt;http://www.codedata.com.tw/social-coding/docker-layman-abc/&lt;/a&gt; 受到關注, 至今已經是業界一致推崇的虛擬技術.

Docker 電子書: &lt;a href="http://yeasy.gitbooks.io/docker_practice/content/"&gt;http://yeasy.gitbooks.io/docker_practice/content/&lt;/a&gt;

首先是透過 &lt;a href="https://docs.docker.com/installation/ubuntulinux/"&gt;https://docs.docker.com/installation/ubuntulinux/&lt;/a&gt; 安裝 Docker.

&lt;!--more--&gt;

在 14.04 LTS 安裝:

sudo wget -qO- https://get.docker.com/ | sh

安裝結束後重新啟動.

利用 &lt;a href="https://github.com/ipedrazas/taiga-docker"&gt;https://github.com/ipedrazas/taiga-docker&lt;/a&gt; 中的 setup.py 與 run-taiga.sh 進行安裝與啟動.

完成後, 就可以利用瀏覽器 localhost:8000, 以 admin/123123 帳號密碼登入了.

參考:

&lt;a href="https://github.com/jwilder/nginx-proxy"&gt;https://github.com/jwilder/nginx-proxy&lt;/a&gt;

&lt;a href="https://github.com/ianmiell/shutit"&gt;https://github.com/ianmiell/shutit&lt;/a&gt;

&lt;a href="https://zwischenzugs.wordpress.com/2014/10/07/using-shutit-to-build-your-own-taiga-server/"&gt;https://zwischenzugs.wordpress.com/2014/10/07/using-shutit-to-build-your-own-taiga-server/&lt;/a&gt;

&lt;a href=http://dockerpool.com/"&gt;http://dockerpool.com/&lt;/a&gt;

</t>
<t tx="amd.20150326120643.3">10</t>
</tnodes>
</leo_file>
