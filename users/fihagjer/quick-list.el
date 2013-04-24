;;fihagjer changes
(add-to-list 'load-path "./site-lisp/emacs-nav/")
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
(global-set-key [f8] 'nav-toggle)

(defun svn-meld ()
  (interactive)
  (let* (file (buffer-file-name))
    (shell-command (concat "svn diff --diff-cmd=/usr/bin/meld " file ))))

(defun svn-kompare ()
  (interactive)
  (let* (file (buffer-file-name))
  (shell-command (concat "svn diff " file "| kompare -o -"))))

(defun lookup-file2 (path file)
  (interactive "DPath: \nsFile: \n" )
  (find-dired path (concat "-type f -name '*" file "*'")))

(defun lookup-file (path)
  (interactive "Dpath: ")
  (let ((ffip-project-root path))
    (call-interactively 'find-file-in-project)))


(defun comment-current-line()
  (interactive)
  (beginning-of-visual-line)
  (insert "//"))

;; F6 copy whole buffer
(defun copy-whole-buffer ()
  "Copy entire buffer to clipboard"
  (interactive)
  (clipboard-kill-ring-save (point-min) (point-max)))

(defun load-init-file ()
  "load-file ~/.emacs.d/init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el"))


(provide 'quick-list)
