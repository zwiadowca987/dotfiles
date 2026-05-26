;;; -*- lexical-binding: t; coding: utf-8; -*-

;; =======================================================================
;; USTAWIENIA KODOWANIA UTF-8
;; =======================================================================

(set-language-environment "UTF-8")
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(setq default-universal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; =======================================================================
;; SYSTEM PAKIETÓW (package.el + use-package)
;; =======================================================================

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; =======================================================================
;; WYGLĄD
;; =======================================================================

(use-package autothemer :ensure t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") (load-theme 'rose-pine t)
;(use-package catppuccin-theme :ensure t :config (setq catppuccin-flavor 'frappe)) (load-theme 'catppuccin t)
;(use-package catppuccin-theme :ensure t :config (setq catppuccin-flavor 'macchiato)) (load-theme 'catppuccin t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package nerd-icons :ensure t)
(use-package nerd-icons-dired :ensure t :hook (dired-mode . nerd-icons-dired-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package spacious-padding
  :ensure t
  :config
  (setq spacious-padding-widths
        '(:internal-border-width 40
          :header-line-width 4
          :mode-line-width 4
          :tab-width 4
          :right-divider-width 20
          :scroll-bar-width 8))
  (spacious-padding-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; =======================================================================
;; CZCIONKA
;; =======================================================================

;; Domyślna czcionka
(set-face-attribute 'default nil
                    :family "IoskeleyMonoNL Nerd Font SemiCondensed"
                    :height 250
                    :weight 'regular
                    :slant 'normal)

;; Ustawienie kursywy, jeśli font ją ma
(set-face-attribute 'italic nil
                    :family "IoskeleyMonoNL Nerd Font SemiCondensed"
                    :slant 'italic)

;; Domyślna czcionka
;(set-face-attribute 'default nil
;                    :family "JetBrains Mono"
;                    :height 250
;                    :weight 'regular
;                    :slant 'normal)

;; Ustawienie kursywy, jeśli font ją ma
;(set-face-attribute 'italic nil
;                    :family "JetBrains Mono"
;                    :slant 'italic)


;; Wyłączanie ligatur
(global-prettify-symbols-mode -1)

;; Ustaw kursor na pionową kreskę (|)
(add-hook 'after-init-hook (lambda () (setq-default cursor-type '(bar . 3))))

;; Wartość,Wygląd kursora,Opis
;; box,Kwadratowy blok (█),Domyślny kursor.
;; bar,**Pionowa kreska (`,`)**
;; hollow,Pusty kwadrat (◻),Kursor otoczony ramką.
;; hline,Pozioma linia (_),Podkreślenie.
;; nil,Brak (ukryty),Ukrywa kursor.

;; =======================================================================
;; EDYCJA TESKTU
;; =======================================================================

;; Nadpisywanie zaznaczonego tekstu
(delete-selection-mode 1)
;; Pokazuje zaznaczenie na ekranie
(transient-mark-mode 1)
;; Podświetlanie bieżącej linii
(global-hl-line-mode 1)
;; Zawijanie linii bez łamania słów
(global-visual-line-mode 1)
;; --- Smooth scrolling o 1 linijkę ---
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-margin 0)
;; --- Scrolling myszy o 1 linię ---
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)
;; Python jako wcięcie używa 4 spacje
(setq python-indent-offset 4)
;; Klawisz Insert wyłącza
(global-unset-key (kbd "<insert>"))
;; Automatyczne zamykanie nawiasów
(electric-pair-mode 1)
;; Wyłączenie podświetlania nawiasów (żeby nie pokazywał błędów/niedopasowań)
(show-paren-mode -1)

;; SCHOWEK - KOPIOWANIE I WKLEJANIE
(when (and (not (display-graphic-p))
           (executable-find "wl-paste"))
  (setq interprogram-cut-function
        (lambda (text)
          (let ((process-connection-type nil))
            (let ((proc (start-process "wl-copy" nil "wl-copy")))
              (process-send-string proc text)
              (process-send-eof proc)))))
  (setq interprogram-paste-function
        (lambda ()
          (shell-command-to-string "wl-paste --no-newline"))))

;; =======================================================================
;; DIRED
;; =======================================================================

;; Sortowanie w dired
(setq dired-listing-switches "-ahl --group-directories-first")

;; =======================================================================
;; PODPOWIEDZI
;; =======================================================================

;; Podpowiada klawisze
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Rust-Mode
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'")

;; C#-Mode
(use-package csharp-mode
  :ensure t
  :mode "\\.cs\\'")

;; --- GOLANG (KISS VERSION) ---
(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
  ;; Automatyczne układanie kodu (gofmt) przy każdym zapisie pliku
  ;; Dzięki temu nie musisz się martwić o spacje i taby - Emacs zrobi to za Ciebie.
  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; Ustawienie szerokości tabulacji (zgodnie ze standardem Go)
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode t))

;; Wyrzuć company całkowicie, zastąp tym:
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.3
        corfu-auto-prefix 2))

(use-package cape
  :ensure t
  :init
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (list (cape-capf-super
                                 #'cape-keyword
                                 #'cape-dabbrev))))))

(use-package flycheck
  :ensure t
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)
        flycheck-idle-change-delay 1.5)
  (global-flycheck-mode 1)
  ;; Użyj pyright zamiast pycompile
  (add-hook 'python-mode-hook
            (lambda ()
              (flycheck-select-checker 'python-pyright))))

; =======================================================================
;; ORG-MODE
;; =======================================================================

;; Upewnij się że org-mode i org-babel są załadowane
(require 'org)
(require 'ob)

;; Włącza wykonywanie kodu w org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)   ; Emacs Lisp
   (python . t)       ; Python
   (java . t)         ; Java
   (js . t)           ; JavaScript
   (shell . t)        ; Skrypty powłoki (bash/sh)
;   (rust . t)
   (calc . t)
   (R . t)
   ))

;; Ustawienie ścieżki do Pythona
(setq org-babel-python-command "python3")

;; Aby company nie podpowiadało zwykłych słów w org-mode
;; W org-mode wyłącz dabbrev dla tekstu
(defun my/org-mode-company-setup ()
  "Wyłącz podpowiedzi z tekstu w org-mode."
  (setq-local company-backends
              '((company-capf company-dabbrev-code)))) ;; dabbrev-code = tylko kod

(add-hook 'org-mode-hook #'my/org-mode-company-setup)

;; PlantUML
(setq org-plantuml-jar-path "D:\plantuml-gplv2-1.2025.10.jar")

;; gnuplot
(use-package gnuplot :ensure t)

;; R
;; pojedyńczy blok
(setq org-babel-R-command "C:/Progra~1/R/R-4.4.2/bin/R.exe --slave --no-save")
;; blok w sesji
(setq inferior-R-program-name "C:/Progra~1/R/R-4.4.2/bin/x64/Rterm.exe")

;; Kolorowanie składni R
(use-package ess :ensure t)

;; Wyłącz pytanie "Evaluate this code block in your system?"
(setq org-confirm-babel-evaluate nil)

;; Nie ruszaj moich wcięć w bloku BEGIN_SRC...END_SRC
(setq org-src-preserve-indentation t org-edit-src-content-indentation 0)

;; Nawiasy po wprowadzeniu linku [[]] zawsze mają być widoczne
(setq org-descriptive-links nil)

;; =======================================================================
;; LATEX
;; =======================================================================

;; Większa czcionka podglądu Latex
(with-eval-after-load 'org
  ;; Skala 2.0 (zmień na 1.5, 2.5 itd.)
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 2.0))
  )

;; lualatex preview
(setq org-latex-compiler "lualatex")

(with-eval-after-load 'org
  (setq org-preview-latex-process-alist
        '((imagemagick
           :programs ("lualatex" "magick")
           :description "Preview LaTeX using lualatex and ImageMagick"
           :message "You need lualatex and ImageMagick installed."
           :image-input-type "pdf"
           :image-output-type "png"
           :image-size-adjust (1.0 . 1.0)
           :latex-compiler ("lualatex -interaction nonstopmode -output-directory %o %f")
           :image-converter ("magick -density %D %f -trim %O")))))

(setq org-preview-latex-default-process 'imagemagick)

;; Kolorowanie składni w blokach kodu po eksporcie do pdf
(with-eval-after-load 'ox-latex
  (setq org-latex-listings 'minted))
  
;; Własna klasa Latex która pozwala na wklejenie jedynie
;; ------
;; #+LATEX_CLASS: pl-article
;; #+LATEX_COMPILER: lualatex
;; #+OPTIONS: toc:nil title:nil
;; #+LANGUAGE: pl
;; ------
;; na początku pliku org.
(with-eval-after-load 'ox-latex
  (add-to-list
   'org-latex-classes
   '("pl-article"
     "\\documentclass[12pt]{article}
\\usepackage[a4paper,margin=2cm]{geometry}
\\usepackage{fontspec}
\\setmainfont{Latin Modern Roman}
\\setsansfont{Latin Modern Sans}
\\setmonofont{Latin Modern Mono}
\\usepackage{polyglossia}
\\setdefaultlanguage{polish}
\\usepackage{csquotes}
\\setquotestyle{polish}
\\usepackage{microtype}
\\usepackage[hyphenation,lastparline,nosingleletter]{impnattypo}
\\usepackage{setspace}
\\onehalfspacing
\\usepackage{longtable}
\\usepackage{booktabs}
\\usepackage{minted}
\\usepackage{fvextra}
\\setminted{
  fontsize=\\small,
  linenos,
  breaklines,
  tabsize=2,
  xleftmargin=1em,
  framesep=2mm
}
\\usemintedstyle{emacs}
% --- grafika ---
\\usepackage{graphicx}
\\usepackage{float}
\\usepackage{caption}
\\captionsetup{font=small, labelfont=bf}
% --- bibliografia ---
\\usepackage[
  backend=biber,
  style=numeric,
  sorting=none,
  urldate=iso
]{biblatex}
\\addbibresource{bibliografia.bib}
% --- hiperłącza (na końcu żeby nie gryźć się z innymi) ---
\\usepackage[hidelinks]{hyperref}
% --- sieroty i wdowy ---
\\clubpenalty=10000
\\widowpenalty=10000"
     ("\\section{%s}" . "\\section*{%s}")
     ("\\subsection{%s}" . "\\subsection*{%s}")
     ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

;; BibLaTeX wymaga biber — dodaj go do procesu kompilacji
(setq org-latex-pdf-process
      '("lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "biber %b"
        "lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "lualatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; =======================================================================
;; ZAKOŃCZENIE
;; =======================================================================

;; ostatnia linijka w pliku init
(provide 'init)
;;; init.el ends here
