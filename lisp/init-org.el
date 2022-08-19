;;; init-org.el --- Measure startup and require times -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package org
  :config
  (setq org-src-fontify-natively t)
  (setq org-agenda-files '("~/org")))


(provide 'init-org)

;;; init-org.el ends here
