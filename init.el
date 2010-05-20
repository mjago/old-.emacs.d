;; list-colors-display --> display colour palette
;; mark selection semi-permanently 
(global-hi-lock-mode 1)
;; C-x w h REGEX <RET> <RET> to highlight all occurances of REGEX, and
;; C-x w r REGEX <RET>  to unhighlight them again.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit/jabber"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; Colour Themes
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))
(require 'color-theme)
;;(color-theme-initialize)
;; (color-theme-blue-mood)

(defun color-theme ()
  (interactive)
  (color-theme-install
   '(color-theme
      ((background-color . "#0e52a0")
      (background-mode . dark)
      (border-color . "#1a1a1a")
      (cursor-color . "#fce94f")
      (foreground-color . "#ffffff")
      (mouse-color . "black"))
     (fringe ((t (:background "#1a1a1a"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#2e4a12"))))
;;     (mode-line ((t (:foreground "#eeeeec" :background "#ff0000"))))
     (region ((t (:background "#0eaa2f"))))
     (font-lock-builtin-face ((t (:foreground "#d7e3ef"))))
;;     (font-lock-comment-face ((t (:foreground "#a6ed3b"))))
     (font-lock-comment-face ((t (:foreground "#D0D9D8"))))
     (font-lock-function-name-face ((t (:foreground "#edd400"))))
;;     (font-lock-keyword-face ((t (:foreground "#faeb00"))))
     (font-lock-keyword-face ((t (:foreground "#E1D400"))))
;;     (font-lock-string-face ((t (:foreground "#ff8ff3"))))
     (font-lock-string-face ((t (:foreground "#FCE8FC"))))
;;     (font-lock-type-face ((t (:foreground"#8ae234"))))
     (font-lock-type-face ((t (:foreground"#f89254"))))
     (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
     (minibuffer-prompt ((t (:foreground "#bbd8f7" :bold t))))
     (font-lock-warning-face ((t (:foreground "#FF0000" :bold t))))
     (highlight ((t (:background "#130EA1" :foreground "#EEFFFF"))))
     )))
(provide 'color-theme)
(require 'color-theme)
(color-theme-initialize)
(color-theme)
(color-theme-blue-mood)

(require 'setnu)

(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)
    
;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; this must be loaded before ELPA since it bundles its own
;; out-of-date js stuff. TODO: fix it to use ELPA dependencies
(load "elpa-to-submit/nxhtml/autostart")

;; Load up ELPA, the package manager

(require 'package)
(package-initialize)
(require 'starter-kit-elpa)

;; Load up starter kit customizations

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-js)
(regen-autoloads)
(load custom-file 'noerror)

;; More complicated packages that haven't made it into ELPA yet

(autoload 'jabber-connect "jabber" "" t)
;; TODO: rinari, slime

;; Work around a bug on OS X where system-name is FQDN
(if (eq system-type 'darwin)
    (setq system-name (car (split-string system-name "\\."))))

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))

;; ruby                                                                         
;; based on http://www.rubygarden.org/Ruby/page/show/InstallingEmacsExtensions  
;;                                                                              

(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby")

 (autoload 'ruby-mode "ruby-mode"
     "Mode for editing ruby source files")
 (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 (autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
 (autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))
 ;; If you have Emacs 19.2x or older, use rubydb2x                              
 (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
 ;; uncomment the next line if you want syntax highlighting                     
 (add-hook 'ruby-mode-hook 'turn-on-font-lock)

 ;;(add-hook 'ruby-mode-hook 'whitespace-mode)

 (require 'show-wspace) ; Load this library.

; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "~/.emacs.d/mode-compile.elc"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

;;;Emacs code browser doesn't appear to work in windows
;;;(add-to-list 'load-path
;;;             "~/.emacs.d/vendor/ecb")
;;;(require 'ecb)

;; ;Allows syntax highlighting to work, among other things
;; (global-font-lock-mode 1)
;; ;These lines are required for ECB
;; (add-to-list 'load-path "C:\.emacs.d\vendor\ecb\eieio"
;; (add-to-list 'load-path "C:/emacs-22.1/plugins/speedbar-0.14beta4")
;; (add-to-list 'load-path "C:/emacs-22.1/plugins/semantic-1.4.4")
;; (setq semantic-load-turn-everything-on t)
;; (require 'semantic-load)
;; ; This installs ecb - it is activated with M-x ecb-activate
;; (add-to-list 'load-path "C:/emacs-22.1/plugins/ecb-2.32")
;;(require 'ecb-autoloads)

(require 'cc-mode)

(global-set-key [(f9)] 'compile)
(global-font-lock-mode 1)

(require 'smooth-scrolling)
;; (require 'psvn.el)
;;;(require 'whitespace-mode)

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'auto-complete-ruby)
(global-auto-complete-mode t)

;; make C-k kill whole line...
(setq kill-whole-line t)

;; Mark displayed as inverse colour
(setq-default transient-mark-mode t)

(defun goto-next-line()
  (interactive)
  (move-end-of-line 1)
  (newline)
  (indent-according-to-mode)
  )
(global-set-key (kbd "C-j") 'goto-next-line)

(when (require 'auto-complete nil t)
   (require 'auto-complete-yasnippet)
   (require 'auto-complete-ruby)
;;   (require 'auto-complete-css)
 
   (global-auto-complete-mode t)
;;   (set-face-background 'ac-menu-face "lightgray")
;;   (set-face-underline 'ac-menu-face "darkgray")
;;   (set-face-background 'ac-selection-face "steelblue")
   (define-key ac-complete-mode-map "\t" 'ac-expand)
   (define-key ac-complete-mode-map "\r" 'ac-complete)
   (define-key ac-complete-mode-map "\M-n" 'ac-next)
   (define-key ac-complete-mode-map "\M-p" 'ac-previous)
   (setq ac-auto-start 3)
   (setq ac-dwim t)
;   (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))
 
   (setq ac-modes
         (append ac-modes
                 '(eshell-mode
                   ;org-mode
                   )))
   ;(add-to-list 'ac-trigger-commands 'org-self-insert-command)
 
;   (add-hook 'emacs-lisp-mode-hook
;             (lambda ()
;               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))
 
;   (add-hook 'eshell-mode-hook
;             (lambda ()
;               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer))))
 
   (add-hook 'ruby-mode-hook
             (lambda ()
               (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools))))))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;(global-set-key "\C-z" 'undo)
(require 'redo)
(define-key global-map (kbd "M-z") 'redo)
(define-key global-map (kbd "C-z") 'undo)
;;(define-key global-map (kbd "5") 'self-insert-command)

;; Shift F10 Open .emacs in buffer

;;save all buffers with F4 function key...
(defun force-save-all ()
    "Unconditionally saves all unsaved buffers."
    (interactive)
    (save-some-buffers t))

(global-set-key [f4] 'force-save-all)
 
;; Change IRC user info...
(setq rcirc-default-nick "rninja")
(setq rcirc-default-user-name "rninja")
;;(setq rcirc-default-user-full-name "")
      
;; Join these channels at IRC startup...
(setq rcirc-startup-channels-alist
      '(("\\.freenode\\.net$" "#git" "#rspec")))

(require 'keywiz)

;;(add-to-list 'load-path
;;                  "~/.emacs.d/yasnippet-ruby-mode")
;;    (require 'yasnippet) ;; not yasnippet-bundle
;;    (yas/initialize)
;;    (yas/load-directory "~/.emacs.d/yasnippet-ruby-mode")

;;   1. In your .emacs file:
;;        (add-to-list 'load-path "/dir/to/yasnippet.el")
        (require 'yasnippet)
;;   2. Place the `snippets' directory somewhere.  E.g: ~/.emacs.d/snippets
;;   3. In your .emacs file
        (setq yas/root-directory "~/.emacs.d/snippets/yasnippet-0.6.1c/yasnippet-0.6.1c/snippets/text-mode")
        (yas/initialize)
        (yas/load-directory yas/root-directory)
;;    (yas/load-directory "~/.emacs.d/yasnippet-ruby-mode")
;;   4. To enable the YASnippet menu and tab-trigger expansion
;;        M-x yas/minor-mode
;;   5. To globally enable the minor mode in *all* buffers
;;        M-x yas/global-mode

(setq flymake-no-changes-timeout 9999
      flymake-start-syntax-check-on-newline nil)

;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

(global-unset-key "\M-l")
(global-set-key "\M-l" 'goto-line)

(setq make-backup-files nil) ; stop creating those backup~ files 
(setq auto-save-default nil) ; stop creating those #auto-save# files

;;; init.el ends here


(put 'downcase-region 'disabled nil)

;;; easy bookmarks...

;;; TODO: Need to require this (require 'easy-bookmarks)
(require 'cl)
(require 'bookmark)
(defvar af-current-bookmark nil)

(defun af-bookmark-make-name ()
  "makes a bookmark name from the buffer name and cursor position"
  (concat (buffer-name (current-buffer))
          " - " (number-to-string (point))))

(defun af-bookmark-toggle ()
  "remove a bookmark if it exists, create one if it doesnt exist"
  (interactive)
  (let ((bm-name (af-bookmark-make-name)))
    (if (bookmark-get-bookmark bm-name)
        (progn (bookmark-delete bm-name)
               (message "bookmark removed"))
      (progn (bookmark-set bm-name)
             (setf af-current-bookmark bm-name)
             (message "bookmark set")))))

(defun af-bookmark-cycle (i)
  "Cycle through bookmarks by i.  'i' should be 1 or -1"
  (if bookmark-alist
      (progn (unless af-current-bookmark
               (setf af-current-bookmark (first (first bookmark-alist))))
             (let ((cur-bm (assoc af-current-bookmark bookmark-alist)))
               (setf af-current-bookmark
                     (if cur-bm
                         (first (nth (mod (+ i (position cur-bm bookmark-alist))
                                          (length bookmark-alist))
                                     bookmark-alist))
                       (first (first bookmark-alist))))
               (bookmark-jump af-current-bookmark)
               ;; Update the position and name of the bookmark.  We
               ;; only need to do this when the bookmark has changed
               ;; position, but lets go ahead and do it all the time
               ;; anyway.
               (bookmark-set-position af-current-bookmark (point))
               (let ((new-name (af-bookmark-make-name)))
                 (bookmark-set-name af-current-bookmark new-name)
                 (setf af-current-bookmark new-name))))
    (message "There are no bookmarks set!")))

(defun af-bookmark-cycle-forward ()
  "find the next bookmark in the bookmark-alist"
  (interactive)
  (af-bookmark-cycle 1))

(defun af-bookmark-cycle-reverse ()
  "find the next bookmark in the bookmark-alist"
  (interactive)
  (af-bookmark-cycle -1))

(defun af-bookmark-clear-all()
  "clears all bookmarks"
  (interactive)
  (setf bookmark-alist nil))
(global-set-key [(control f2)]  'af-bookmark-toggle )
(global-set-key [f2]  'af-bookmark-cycle-forward )
(global-set-key [(shift f2)]  'af-bookmark-cycle-reverse )
(global-set-key [(control shift f2)]  'af-bookmark-clear-all )

;disable backup
(setq backup-inhibited t)

;disable auto save
(setq auto-save-default nil)

(server-start)
