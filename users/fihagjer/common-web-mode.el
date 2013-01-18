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

;;(defvar common-web-target-dir "/finn/svn/trunk/licensee-finn/finn/overlays/no.finntech.commons-web-*")
(defvar common-web-target-dir "/finn/svn/trunk/licensee-finn/finn/target/exploded")
(defun common-web-hot-deploy-buffer-file ()
  "If the current buffer is visiting a file, and that file is deployed
in an exploded war, re-deploy the file."
  (interactive)
  (let* ((source (buffer-file-name))
         (target (s-with source
                   (s-replace "/finn/repo/common-web/trunk/commons-web/src/main/webapp" common-web-target-dir)
                   (s-replace "/finn/repo/common-web/trunk/analytics-js/src/main/webapp" common-web-target-dir)
                   (s-replace "/finn/repo/common-web/trunk/core-js/src/main/webapp" common-web-target-dir)
                   (s-replace "/finn/repo/common-web/trunk/mupf-js/src/main/webapp" common-web-target-dir))))
    (if (and (file-writable-p target)
             (not (string= source target)))
        (progn
          (copy-file source target t)
          (message (concat "Deployed " source " to " target)))
      (message (concat target " does not exist, file not deployed")))))

(define-minor-mode common-web-mode
  "Convenience utilities for working with Finn IAD"
  nil " IAD" nil
  (if common-web-mode
      (add-hook 'after-save-hook 'common-web-hot-deploy-buffer-file nil t)
    (remove-hook 'after-save-hook 'common-web-hot-deploy-buffer-file t)))

(eval-after-load "grep"
  '(progn (add-to-list 'grep-find-ignored-directories "tinymce")
          (add-to-list 'grep-find-ignored-directories "external")))

(provide 'common-web-mode)
;;; common-web-mode.el ends here
