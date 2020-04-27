;; (setq debug-on-error nil)

;; Minimal UI
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))
;;(scroll-bar-mode -1)
;(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-linum-mode t)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(set-cursor-color "#c90e30")
(setq-default cursor-type 'bar)

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; don't allow suspending emacs shortcut in GUI mode
(when (display-graphic-p)
  (global-unset-key (kbd "C-z"))
  )

;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; duplicate line shortcut
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key "\C-c\C-d" 'duplicate-line)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; kill line if no region active                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://emacs-fu.blogspot.co.uk/2009/11/copying-lines-without-selecting-them.html
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; Changing windows in emacs
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "C-x o") 'ace-window))

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))


;; Display column number
(column-number-mode)
;; show the other parenthesis
(show-paren-mode)

;; Highlight tabulations
(setq-default highlight-tabs t)
;; Show trailing white spaces
(setq-default show-trailing-whitespace t)
;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda()
			      (yafolding-show-all)
			      (delete-trailing-whitespace)))

;; Highlight current line
(global-hl-line-mode t)


;; auto completion
;;(ido-mode t)

;;(windmove-default-keybindings)

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
  helm-mode-fuzzy-match t
  helm-buffers-fuzzy-matching t
  helm-recentf-fuzzy-match t
  helm-locate-fuzzy-match t
  helm-semantic-fuzzy-match t
  helm-imenu-fuzzy-match t
  helm-completion-in-region-fuzzy-match t
  helm-candidate-number-list 150
  helm-split-window-inside-p t
  helm-move-to-line-cycle-in-source t
  helm-display-header-line t
  helm-echo-input-in-header-line nil
  helm-autoresize-max-height 0
  helm-autoresize-min-height 20
  )
  :bind
  (("C-x b" . helm-buffers-list)
   ("M-y" . helm-show-kill-ring)
   ("M-x" . helm-M-x)
   )
  :config
  (helm-mode 1)
;;  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  )


(use-package undo-tree
  :ensure t
  :config
    ;;turn on everywhere
    (global-undo-tree-mode 1)
    (global-set-key (kbd "C-_") 'undo)
    (defalias 'redo 'undo-tree-redo)
    (global-set-key (kbd "M-_") 'redo)
  )

(use-package magit
  :ensure t
  :bind
  (
   ("C-x g" . magit-status)
   )
  )

(use-package autopair
  :ensure t
  :config
  (autopair-global-mode 1)
  (setq autopair-autowrap t)
  )

(use-package helm-swoop
  :ensure t
  :bind
  (
   ("M-i" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   (:map helm-swoop-map
	 ("C-r" . helm-previous-line)
	 ("C-s" . helm-next-line)
	 )
   )
   :config
  ;; If this value is t, split window inside the current window
   (setq helm-swoop-split-with-multiple-windows t)
  )

(use-package docker-tramp
  :ensure t)

(use-package fill-column-indicator
  :ensure t
  )

(use-package dockerfile-mode
  :ensure t
  :config
  (add-hook 'dockerfile-mode-hook
	    (lambda ()
	      (interactive)
	      (fci-mode t)
	      (set-fill-column 80)))
  )

(use-package docker-compose-mode
  :ensure t)

(use-package helm-tramp
  :ensure t
  :bind
  (
   ("C-c s" . helm-tramp)
   )
  )

(use-package drag-stuff
  :ensure t
  :config
   (drag-stuff-global-mode 1)
   (drag-stuff-define-keys)
   )

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  )

(use-package groovy-mode
  :ensure t
  :config
  (setq indent-tabs-mode nil)
  (setq groovy-indent-offset 2)
  )

(use-package yaml-mode
  :ensure t)

(use-package expand-region
  :ensure t
  :bind
  (
   ("C-=" . er/expand-region)
   )
  )

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
  )

(use-package recentf
  :ensure t
  :config
  (recentf-mode 1)
  :bind
  ("\C-xf" . recentf-open-files)
  )

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-items '((recents  . 10)
			    (bookmarks . 10)))
  (dashboard-setup-startup-hook)
  )


(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1)
  (setq telephone-line-lhs
      '((evil   . (telephone-line-evil-tag-segment))
	(accent . (telephone-line-vc-segment
		   telephone-line-erc-modified-channels-segment
		   telephone-line-process-segment))
	(nil    . (telephone-line-minor-mode-segment
		   telephone-line-buffer-segment))))
  (setq telephone-line-rhs
      '((nil    . (telephone-line-misc-info-segment))
	(accent . (telephone-line-major-mode-segment))
	(evil   . (telephone-line-airline-position-segment))))
  )

(use-package sublimity
  :ensure t
  :config
  (sublimity-mode 1)
  (require 'sublimity-scroll)
  ;;(require 'sublimity-map) ;; experimental
  ;; (require 'sublimity-attractive)
  )

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  (setq beacon-size 20)
  (setq beacon-color "#ba1010")
  (setq beacon-blink-duration 0.5)
  (setq beacon-blink-when-window-scrolls t)
  (setq beacon-blink-when-window-changes t)
  (setq beacon-blink-when-point-moves-horizontally nil)
  (setq beacon-blink-when-point-moves-vertically 10)
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . gfm-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command
	      "pandoc -f markdown -t html -s --mathjax --highlight-style=pygments")
  )

(use-package py-autopep8
  :ensure t
  )

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
  )

(use-package smart-shift
  :ensure t
  :after yaml-mode
  :hook (yaml-mode . smart-shift-mode)
 )

(use-package yafolding
  :ensure t
  :after yaml-mode
  :hook (yaml-mode . yafolding-mode)
  )

(define-key yafolding-mode-map (kbd "C-c C-f") 'yafolding-toggle-all)
;(define-key yafolding-mode-map (kbd "C-c v") 'yafolding-hide-parent-element)
(define-key yafolding-mode-map (kbd "C-c f") 'yafolding-toggle-element)

(define-key yaml-mode-map (kbd "C-c C-c") 'comment-line)

(use-package highlight-indentation
  :ensure t
  :after yaml-mode
  :hook (yaml-mode . highlight-indentation-mode)
  :config
  (set-face-background 'highlight-indentation-face "#222527")
  (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
