## Navigation

-   TAB
-   C-c C-n
-   C-c C-p
-   M-x up-list => jump to 最近的 clojure. Alt-x

## File

-   SPC p o => 项目下的新 org 文件
-   SPC p t
-   SPC p f
-   SPC p b
-   SPC b b
-   SPC f R ==> file rename
-   SPC f r ==> recent file list
-   SPC f y => copy file path

## table

-   , t n => create a table
-   , t i h => inser a horizontal line
-   , t a => auto align
-   =$1*$2 => auto calculate for the whole table
-   :=$1*$2 => auto calculate for the cell
-   C-c C-c on the formula line to refresh calculate result

## task

-   , , => auto calculate, mark task completion
-   , T T => set title's progress, shift + <arrow> to switch
-   T => task Todo/done
-   , T => show only todo tasks
-   , d => assign schedule to task

## export

-   , e e

## search

-   SPC s s
-   SPC s S
-   SPC s c => 清除高亮
-   -   => press \* under the word to be searched
-   SPC s a b => 对当前打开的所有 buffers, need brew install the_silver_searcher
-   SPC s a a => 对当前文件
-   SPC \* => seach current word under cursor

## source code

-   , i b s

## shell

-   SPC SPC eshell
-   SPC '
-   SPC a s

## configuration

-   SPC f e R => reload
-   SPC z x => change font
-   M-x text-mode
-   C-z => switch vim/emacs mode

## jump

-   g d => go to definition
-   C-o => jump back from g d
-   SPC s j => jump to ...

## scratch

-   C-x C-e => execute

## org

-   SPC j i => search org title headers
-   C-c [ => add current file to agenda
-   SPC a o o => open agenda options

## editing

-   SPC t l => wrap line
-   SPC t f => show 80 column line
-   SPC c l => comment line
-   SPC c p => comment a phase
-   q% => start a macro which name is %
-   q => stop macro
-   @% => execute macro %

-   list item 1
-   list item 2
-   [[https://www.qsl.net/bh4dcl][bh4dcl]]
-   +through+
-   _bold_
-   /itatics/

##+BEGIN_SRC c
uchar msg = '';
##+END_SRC

task list[0/2]

-   [ ] task 1
-   [ ] task 2

| date   | task   | desc   | status   | comments   |
| ------ | ------ | ------ | -------- | ---------- |
|        | add    | 5      | 2        | 7          |
|        | sub    | 10     | 3        | 7          |
|        |        | 9      |          |            |
| ------ | ------ | ------ | -------- | ---------- |
|        | mean   | 8      |          |            |

##+TBLFM: @5$3=vmean(@2$3..@4$3)::@2$5=$3+$4::@3$5=$3-\$4

-   , T i => toggle inline images

## 配置

-   SPC f e d 编辑配置文件

## 项目管理

-   SPC p p 切换项目目录（.git 文件夹，或者 .projectile 文件）

## 窗口管理

-   SPC w - 水平切分窗口
-   SPC w / 垂直切分窗口
-   SPC w w 窗口轮询
-   SPC 0-9 切换窗口
-   SPC w r/R 交换窗口之间的位置
-   SPC w d 关闭窗口
-   SPC w o 打开新的 Frame
-   SPC w . 进入窗口管理状态

## buffer 管理

-   SPC b b 从 buffer 列表中选择一个并在当前窗口中打开
-   SPC TAB 在当前窗口中轮流打开 buffer
-   SPC b d 删除当前活动的 buffer
-   SPC b s 切换到 scratch buffer
-   SPC b R 从磁盘重新加载 buffer
-   SPC b w 切换只读状态
-   \[ b 上一个 buffer
-   \] b 下一个 buffer

## 文件管理

-   nerdtree-toggle \[F8\]
-   (global-set-key [f8] 'neotree-toggle)
-   SPC f c 把当前文件拷贝到另一个地方

## 主题

-   SPC T n 切换下一个主题

## evil

-   \$ brew cask install emacs
-   编辑 ~/.emacs.d/init.el
    (require 'package)
    (let\* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
    (not (gnutls-available-p))))
    (proto (if no-ssl "http" "https")))
    (when no-ssl
    (warn "\
    Your version of Emacs does not support SSL connections,
    which is unsafe because it allows man-in-the-middle attacks.
    There are two things you can do about this warning:

1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
   ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
   ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
   (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
   (when (< emacs-major-version 24)
   ;; For important compatibility libraries like cl-lib
   (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
   (package-initialize)

-   M-x package-refresh-packages
-   init.el
    (require 'evil)
    (evil-mode 1)
