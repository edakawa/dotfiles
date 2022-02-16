;;; init.el --- Emacs 設定ファイル -*- lexical-binding: t; -*-
;;
;; Hajime Edakawa, hajime.edakawa@gmail.com, public domain

;;; Commentary:
;;
;; 1) flycheck
;;
;;    LLVM/Clang を使う
;;
;; 2) iedit
;;
;;    ターミナルエミューレータ上の Emacs からは C-; が無効になるため C-c ; に変更した
;;
;; 3) clang-complete-async
;;
;;    ビルドに必要な make が gmake のため BSD では別途 gmake をインストールする
;;
;; 4) Emacs Server
;;
;;    tmux やターミナル上で Emacs が起動している場合はオプション -{nw|t|tty} を指定する
;;
;;      $ emacsclient -nw filename
;;

;;; Code:

;; el-get
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; for Common Lisp
;;(el-get-bundle 'slime)

;; SBCLをデフォルトのCommon Lisp処理系に設定
;(setq inferior-lisp-program "sbcl")
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;(require 'slime)
;(slime-setup '(slime-repl slime-fancy slime-banner))

;; リアルタイム構文チェッカ
(el-get-bundle flycheck
  (global-flycheck-mode)
  (define-key global-map (kbd "\C-cn") 'flycheck-next-error)     ; 次のエラー/警告に移動する
  (define-key global-map (kbd "\C-cp") 'flycheck-previous-error) ; 前のエラー/警告に移動する
  (define-key global-map (kbd "\C-cd") 'flycheck-list-errors))   ; エラー/警告の一覧を表示する

;; 日本語入力
;(el-get-bundle ddskk
;  (global-set-key (kbd "C-x j") 'skk-mode)
;  ;; (修正) s/setq/defvar/ --- *Compile-Log* Warning: assignment to free variable
;  (defvar default-iput-method "japanese-skk"))

;; バッファ内のテキストを複数同時編集
(el-get-bundle iedit
  (define-key global-map (kbd "C-c ;") 'iedit-mode)		  ; 起動/終了する
  (define-key global-map (kbd "C-c h") 'iedit-restrict-function)) ; 範囲を関数内に制限する

;; LLVM/Clang を使用した C/C++ 補完
;(el-get-bundle clang-complete-async
;	       :build (("gmake"))
;	       (defun ac-cc-mode-setup ()
;		 (setq ac-clang-complete-executable
;		       (locate-user-emacs-file "el-get/el-get/clang-complete-async/clang-complete"))
;		 (setq ac-sources '(ac-source-clang-async))
;		 (ac-clang-launch-completion-process))
;	       (defun my-ac-config ()
;		 (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;		 (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;		 (global-auto-complete-mode))
;	       (my-ac-config))

;; インクリメンタルな補完と実行
;(el-get-bundle helm
;  (define-key global-map (kbd "C-x b")   'helm-for-files)
;  (define-key global-map (kbd "C-x C-f") 'helm-find-files)
;  (define-key global-map (kbd "M-x")     'helm-M-x)
;  (define-key global-map (kbd "M-y")     'helm-show-kill-ring))

;; インデクサー
;(el-get-bundle rtags)

;; Emacs Server
;(require 'server)

;(unless (server-running-p)
;  (server-start))

;; C
(require 'cc-mode)

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (c-toggle-hungry-state -1)
	    (setq c-default-style "k&r")
	    (setq c-basic-offset 4)))

(load-theme 'deeper-blue t)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control))))

(set-frame-parameter nil 'alpha 85)
(set-face-background 'mode-line "grey50")
(set-face-attribute 'default nil :family "Hermit" :height 100)
(set-fontset-font (frame-parameter nil 'font)
		  'japanese-jisx0208
		  (font-spec :family "M+1P+IPAG"))

;; モードライン
(line-number-mode 1)             ; 行数表示
(column-number-mode 1)           ; 桁数表示
(size-indication-mode 1)         ; ファイルサイズ表示
(which-function-mode 1)          ; 関数名表示
(setq eol-mnemonic-dos  "[crlf]" ; 改行コード表示
      eol-mnemonic-mac  "[cr]"
      eol-mnemonic-unix "[lf]")

;; ビープ音を無効にする
(setq ring-bell-function 'ignore)

;; スタートアップ画面を非表示にする
(setq inhibit-startup-screen t)

;; メモリ割り当てを増やし GC の回数を減らす
;(setq gc-cons-threshold (* 64 1024 1024))

;; 32 MB より大きいファイルを開くときは警告する
(setq large-file-warning-threshold (* 32 1024 1024))

;; undo を xyzzy ライクにする
(define-key global-map (kbd "C-\\") 'undo)

;; メニューバーを非表示にする
(menu-bar-mode 0)
(tool-bar-mode 0)

;; バックアップファイルを作成しない
(setq backup-inhibited t)

;; 編集モードが Overwrite モードになるとき警告する
(put 'overwrite-mode 'disabled t)

;; コメントスタイル = { indent | multi-line | box }
(setq comment-style 'multi-line)

;; インデントにタブを使わない
(setq-default indent-tabs-mode nil)

;; ナローイング無効を解除する
(put 'narrow-to-region 'disabled nil)

;; yes と no の入力を y と n に簡略化する
(defalias 'yes-or-no-p 'y-or-n-p)

;; 終了コマンドを無効化する
(global-unset-key (kbd "C-x C-c"))
(defalias 'exit 'save-buffers-kill-emacs)

;; 数値を 2 進数の文字列に変換する
(defun int-to-binary-string (i)
  (let ((res ""))
    (while (not (= i 0))
      (setq res (concat (if (= 1 (logand i 1)) "1" "0") res))
      (setq i (lsh i -1)))
    (if (string= res "")
	(setq res "0"))
    res))

;; (引用元) http://www.emacswiki.org/emacs/ElispCookbook
(defun group-number (num &optional size char)
  "Format NUM as string grouped to SIZE with CHAR."
  ;; Based on code for `match-group-float' in calc-ext.el
  (let* ((size (or size 3))
         (char (or char ","))
         (str (if (stringp num)
                  num
                (number-to-string num)))
         ;; omitting any trailing non-digit chars
         ;; NOTE: Calc supports BASE up to 36 (26 letters and 10 digits ;)
         (pt (or (string-match "[^0-9a-zA-Z]" str) (length str))))
    (while (> pt size)
      (setq str (concat (substring str 0 (- pt size))
                        char
                        (substring str (- pt size)))
            pt (- pt size)))
    str))

(setq user-full-name "Hajime Edakawa"
      user-mail-address "hajime.edakawa@gmail.com")

(global-set-key "\C-h" `delete-backward-char)
(global-set-key "\C-\\" `undo)

;;; init.el ends here
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
