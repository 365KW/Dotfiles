;;; early-init.el --- Emacs early init -*- lexical-binding: t; -*-

;;; Commentary:

;; Early initialization to speed up startup.
;; Disables UI elements before frame creation.
;; Bootstraps Elpaca (async package manager).

;;; Code:

;; Disable built-in package.el before init.el
(setq package-enable-at-startup nil)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(alpha-background . 95) default-frame-alist)

;; Bootstrap Elpaca async package manager
(load-file (expand-file-name "elpaca-bootstrap.el" user-emacs-directory))

;;; early-init.el ends here
