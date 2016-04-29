(require 'package)

;; get vim-mode going
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(package-initialize)
(menu-bar-mode 1)
(global-linum-mode 1) ; display line numbers in margin. Emacs 23 only.
(global-hl-line-mode 0) ; turn off highlighting current line

;; get clojure highlighting
(unless (package-installed-p 'clojure-mode)
  (package-refresh-contents))

(recentf-mode 1) ; keep a list of recently opened files
(set-default-font "-apple-Monaco-medium-normal-normal-*-14-*-*-*-m-0-iso10646-1")

;; ctrl+x ctrl+f
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)


;; for rails development - begin
;; =======================================================

;; Syntax Checking
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; Sane indentation
(setq ruby-deep-indent-paren nil)

;; ruby shell inside emacs
(global-set-key (kbd "C-c r r") 'inf-ruby)

;; Projectile...fuzzy search for files using C-c p f and directories using C-c p d
(projectile-global-mode)
(setq projectile-enable-caching t)
;; (add-hook 'ruby-mode-hook 'projectile-on)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; use flx-ido
;;(require 'flx-ido)
;;(ido-mode 1)
;;(ido-everywhere 1)
;;(flx-ido-mode 1)
;;;; disable ido faces to see flx highlights.
;;(setq ido-enable-flex-matching t)
;;(setq ido-use-faces nil)

;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)

(global-company-mode t)
(push 'company-robe company-backends)

;; Save all tempfiles in $TMPDIR/emacs$UID/
  (defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
  (setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
  (setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
  (setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; for rails development - end
;; ===============================================

;; set default window size for gui version
(defun arrange-frame (w h x y)
  "Set the width, height, and x/y position of the current frame"
  (let ((frame (selected-frame)))
    (delete-other-windows)
    (set-frame-position frame x y)
    (set-frame-size frame w h)))

;; run only in gui mode
(if window-system
     (arrange-frame 157 41 2 22))

;; end of window size config

;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; set default theme
;; ESC+x load-theme (tab) to see the others
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa")
;;(load-theme 'bliss t)
;;(load-theme 'sanityinc-tomorrow-bright t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "569dc84822fc0ac6025f50df56eeee0843bffdeceff2c1f1d3b87d4f7d9fa661" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "442c946bc5c40902e11b0a56bd12edc4d00d7e1c982233545979968e02deb2bc" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "8cf464f2062ca1e148290b594e67c859f745c96e" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" default)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;Change the default eshell prompt
  (setq eshell-prompt-function
              (lambda ()
                        (concat (getenv "USER") " $ ")))
