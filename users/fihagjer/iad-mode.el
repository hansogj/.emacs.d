;;; iad-mode.el --- Convenience utilities for working with Finn IAD in Emacs

;; Copyright (C) 2011  Christian Johansen

;; Author: Christian Johansen <christian@moon>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 's)

(defvar iad-target-dir "/licensee-finn/finn/target/exploded")

(defun iad-hot-deploy-buffer-file ()
  "If the current buffer is visiting a file, and that file is deployed
in an exploded war, re-deploy the file."
  (interactive)
  (let* ((source (buffer-file-name))
         (target (s-with source
                   (s-replace "/travel/src/main/webapp" iad-target-dir)
                   (s-replace "/strapon/src/main/webapp" iad-target-dir)
                   (s-replace "/minfinn/src/main/webapp" iad-target-dir)
                   (s-replace "/licensee-finn/finn/src/main/webapp" iad-target-dir))))
    (if (and (file-writable-p target)
             (not (string= source target)))
        (progn
          (copy-file source target t)
          (message (concat "Deployed " source " to " target)))
      (message (concat target " does not exist, file not deployed")))))

(defun amd-builder ()
  "If, in an amd-module, autorun bash-command to build amd-require module and deploy it to target"
  (interactive)
  (setq source (buffer-file-name))
  (when (s-matches? "clientscript/finn/amd" source)
    (message "source matcing")
    (setq output (shell-command-to-string "amd-builder"))
    (message output)
    (message "amd module built and deployed")))




(define-minor-mode iad-mode
  "Convenience utilities for working with Finn IAD"
  nil " IAD" nil
  (if iad-mode

      (add-hook 'after-save-hook (lambda ()
                                   (iad-hot-deploy-buffer-file)
                                   (amd-builder)) nil t)
    (remove-hook 'after-save-hook (lambda ()
                                    (iad-hot-deploy-buffer-file)
                                    (amd-builder)) t)))
;;    (message "\nafter-save-hook-amd\n")
;;    (add-hook 'after-save-hook-amd 'amd-builder nil t)
;;    (remove-hook 'after-save-hook-amd 'amd-builder t)))

(eval-after-load "grep"
  '(progn (add-to-list 'grep-find-ignored-directories "tinymce")
          (add-to-list 'grep-find-ignored-directories "external")))

(provide 'iad-mode)
;;; iad-mode.el ends here