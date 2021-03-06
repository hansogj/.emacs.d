;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;hansogj bindings
(define-key global-map (kbd "M-s +") 'zoom-in)
(define-key global-map (kbd "M-s -") 'zoom-out)

(global-set-key [end] 'end-of-line)
(global-set-key (kbd "C-c l") 'lookup-file)
(global-set-key (kbd "C-c C-l") 'load-init-file)
(global-set-key (kbd "M-⋅") 'comment-current-line)
(global-set-key (quote [f6]) 'copy-whole-buffer)
(global-set-key (kbd "C-x v e") 'vc-ediff)
(global-set-key (kbd "C-+") 'enlarge-font)
(global-set-key (kbd "C-M-+") 'text-scale-decrease)
(global-set-key (kbd "C-x C-.") 'kill-whitespace)
(global-set-key (kbd "C-x C-:") 'one-liner)
(global-set-key (kbd "C-c C") 'comment-box)
(global-set-key (kbd "C-x r a") 'align-regexp)
(global-set-key (kbd "C-x r n") 'rename-file-and-buffer)
(global-set-key (kbd "M-s M-d") 'sgml-delete-tag)
(global-set-key (kbd "C-c t") 'toggle-transparency)
(global-set-key (kbd "C-c C-b") 'set-background-custom)
(global-set-key (kbd "S-M-<down>") 'duplicate-current-line)
(global-set-key [f8] 'neotree-toggle)


(provide 'key-bindings-hansogj)
