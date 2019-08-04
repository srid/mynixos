;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-theme 'doom-challenger-deep)
(setq doom-font (font-spec :family "Roboto Mono" :size 26))

;; For my org.git
(setq gac-automatically-push-p t)

(after! haskell-mode
  ;; rhyolite quasi quotes
  (setq haskell-font-lock-quasi-quote-modes
        (append haskell-font-lock-quasi-quote-modes
                '(("queryQ" . sql-mode)
                  ("executeQ" . sql-mode)
                  ("traceQueryQ" . sql-mode)
                  ("traceExecuteQ" . sql-mode)
                  ("sqlQ" . sql-mode)))))

(map!
  (:map vterm-mode-map
    ;; Easier window movement
    :i "C-h" #'evil-window-left
    :i "C-j" #'evil-window-down
    :i "C-k" #'evil-window-up
    :i "C-l" #'evil-window-right))
