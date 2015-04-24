(message "hello void from quicklist")
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

(defun xit ()
  (interactive)
  (beginning-of-buffer)
  (replace-string " it(" " xit("))

(defun it ()
  (interactive)
  (beginning-of-buffer)
  (replace-string " xit(" " it("))

(defun comment-current-line()
  (interactive)
  (beginning-of-visual-line)
  (insert "//"))

;; F6 copy whole buffer
(defun copy-whole-buffer ()
  "Copy entire buffer to clipboard"
  (interactive)
  (message "buffer copied")
  (clipboard-kill-ring-save (point-min) (point-max)))

(defun load-init-file ()
  "load-file ~/.emacs.d/init.el"
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun kill-whitespace ()
  "Kill the whitespace between two non-whitespace characters"
  (interactive "*")
  (save-excursion
    (save-restriction
      (save-match-data
        (progn
          (re-search-backward "[^ \t\r\n]" nil t)
          (re-search-forward "[ \t\r\n]+" nil t)
          (replace-match "" nil nil))))))

(defun set-alternative-background ()
  "Setting alternative background color"
  (interactive "*")
  (set-background-color "#2d3743"))

(defun one-liner ()
  "kill whitespace befor and after a line"
  (interactive "*")
  (beginning-of-line)
  (kill-whitespace)
  (end-of-line)
  (kill-whitespace))

(defun open-home-folder ()
  "goto home folder"
  (dired "~/"))

(defun protractor (file)
  "Running protractor in shell terminal"
  (interactive "FFile: \n" )
  (message (concat file "conf.js"))
  (shell-command   (concat "protractor "  file)))

(message "goodbye from quicklist")

(provide 'quick-list)
