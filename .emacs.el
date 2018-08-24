(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(global-set-key (kbd "M-r") 'move-to-window-line-top-bottom)
(global-set-key (kbd "C-x p")  'move-cursor-previous-pane)
(global-set-key (kbd "C-x <left>")  'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <up>")    'windmove-up)
(global-set-key (kbd "C-x <down>")  'windmove-down)

(setq x-select-enable-clipboard t)
(setq reb-re-syntax 'string)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(package-selected-packages
   (quote
    (magit ag highlight-symbol intellij-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package intellij-theme :ensure t)

(iswitchb-mode 1)

(global-auto-revert-mode 1)

;;
;; Mouse Support
;;;;;;;;;;;;;;;;;

(xterm-mouse-mode t)


;;
;; Magit
;;;;;;;;;

(defun my-magit-status ()
  (interactive)
  (magit-status "/src"))
(global-set-key (kbd "C-x g") 'my-magit-status)


;;
;; Highlighting
;;;;;;;;;;;;;;;;

(show-paren-mode 1)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(set-variable 'highlight-symbol-idle-delay 0)

;;
;; Scrolling
;;;;;;;;;;;;;

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(setq scroll-conservatively 101)
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))


;;
;; Ansi Term Config
;;;;;;;;;;;;;;;;;;;;

(setq term-buffer-maximum-size 8192)
(global-set-key (kbd "C-c a") '(lambda ()  (interactive) (ansi-term "/bin/bash")))

;; suppress the 'ansi-term has a running process; kill it?' message:
(defun set-no-process-query-on-exit ()
  (let ((proc (get-buffer-process (current-buffer))))
    (when (processp proc)
      (set-process-query-on-exit-flag proc nil))))
(add-hook 'term-exec-hook 'set-no-process-query-on-exit)
 
;; Add kill ring paste shortcut
(eval-after-load "term"
  '(progn
     (message "Installing ansi-term keybindings")
     (define-key term-raw-map (kbd "C-c C-y") 'term-paste)
     (define-key term-raw-map (kbd "M-w") 'kill-ring-save)))
