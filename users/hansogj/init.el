(message " hello from init")
;;hansogj changes
;; (add-to-list 'load-path "./site-lisp/emacs-nav/")
;; (require 'nav)
;; (nav-disable-overeager-window-splitting)
;; ;; Optional: set up a quick key to toggle nav
;; (global-set-key [f8] 'nav-toggle)
(add-to-list 'load-path "site-lisp/emacs-neotree")
(require 'neotree)



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

(defun undebug ()
  (interactive)
  (beginning-of-buffer)
  (replace-string "debugger;" "")
  (replace-string "debugger;\n" ""))


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

(defvar kindOfBlue   "#002b36")
(defvar dreadfullRed "#391111")
(defvar poisonGreen  "#082500")

(defun set-background-custom (color)
  "Setting alternative background color"
  (interactive
   (list
    (completing-read "choose color:" '("gray20" "darkslategray" "black" "kindOfBlue" "dreadfullRed" "poisonGreen"))))
  (if (equal color "kindOfBlue")
      (setq color kindOfBlue)
    nil)
  (if (equal color "poisonGreen")
      (setq color poisonGreen)
    nil)
  (if (equal color "dreadfullRed")
      (setq color dreadfullRed)
    nil)
  (message "change background-color: " color)
  (set-background-color color))

(defun one-liner ()
  "kill whitespace befor and after a line"
  (interactive "*")
  (beginning-of-line)
  (kill-whitespace)
  (end-of-line)
  (kill-whitespace))

(defun split-four ()
  "split window into four balanced verticals"
  (interactive "*")
  (split-window-right)
  (split-window-right)
  (split-window-right)
  (balance-windows))

(defun open-home-folder ()
  "goto home folder"
  (dired "~/"))

(defun protractor (file)
  "Running protractor in shell terminal"
  (interactive "FFile: \n" )
  (message (concat file "conf.js"))
  (shell-command   (concat "protractor "  file)))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
;; (defun rename-file-and-buffer (new-name)
;;   "Renames both current buffer and file it's visiting to NEW-NAME."
;;   (interactive "sNew name: ")
;;   (let ((name (buffer-name))
;;         (filename (buffer-file-name)))
;;     (if (not filename)
;;         (message "Buffer '%s' is not visiting a file!" name)
;;       (if (get-buffer new-name)
;;           (message "A buffer named '%s' already exists!" new-name)
;;         (progn
;;           (rename-file name new-name 1)
;;           (rename-buffer new-name)
;;           (set-visited-file-name new-name)
;;           (set-buffer-modified-p nil))))))

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

;; Default js indentation levels
(setq-default js2-basic-offset 2)
(setq js-indent-level 2)

;; Disallow scrolling with mouse wheel
(when window-system
  (mouse-wheel-mode -1))


;; Font size
(require 'iso-transl)
(require 'transparency)
(require 'key-bindings-hansogj)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;(provide 'quick-list)
