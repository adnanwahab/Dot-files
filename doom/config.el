;;https://github.com/hlissner/.doom.d/tree/master

(defun toggle-evil-mode ()
  "Toggle Evil mode on and off."
  (interactive)
  (if (bound-and-true-p evil-mode)
      (progn
        (evil-mode -1)
        (message "Evil mode disabled"))
    (progn
      (evil-mode 1)
      (message "Evil mode enabled"))))

(global-set-key (kbd "C-!") 'toggle-evil-mode)


;; day9 daily replay analyzer

;;(global-set-key "\C-w" 'my-kill-region-or-backward-word)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;(global-set-key "\C-c\m" 'execute-extended-command)

 (global-set-key (kbd "C-x SPC")
                 (lambda ()
                   (interactive)
                   (find-file "~/Documents/fortress_of_solitude/adnan.org")))
                                        ;https://github.com/skangas/mentor
                                        ; Normal Chat / Interpreter Mode



(require 'gptel) ;; cant read the code on a big system - have to do log experiments - mark of good programmer - figure out how to get it done.
(gptel-make-ollama "baka"             ;Any name of your choosing
  :host "localhost:11434"               ;Where it's running
  :stream t                             ;Stream responses
  :models '("mistral:latest"))
(setq deft-directory "~/Documents/fortress_of_solitude/")
(after! deft
  (setq deft-default-extension "org"))

(defvar mydick (lambda (response info)
                (if (not response)
                    (message "ChatGPT response failed with: %s" (plist-get info :status))
                  (let* ((bounds (plist-get info :context))
                         (beg (car bounds))
                         (end (cdr bounds))
                         (buf (plist-get info :buffer)))
                    (with-current-buffer buf
                      (save-excursion
                        (goto-char beg)
                        (kill-region beg end)
                        (insert response)
                        (set-marker beg nil)
                        (set-marker end nil)
                        (message "Rewrote line. Original line saved to kill-ring.")))))
                ))

(defun gptel-rewrite-and-replace (bounds &optional directive)
  (interactive
   (list
    (cond
     ((use-region-p) (cons (region-beginning) (region-end)))
     ((derived-mode-p 'text-mode)
      (list (bounds-of-thing-at-point 'sentence)))
     (t (cons (line-beginning-position) (line-end-position))))
    (read-string "write good code.")))
  (gptel-request
      (buffer-substring-no-properties (car bounds) (cdr bounds)) ;the prompt
    :system (or directive "only best code. ty.")
    :buffer (current-buffer)
    :context (cons (set-marker (make-marker) (car bounds))
                   (set-marker (make-marker) (cdr bounds)))
    :callback mydick))

(global-set-key (kbd "C-\\") 'gptel-rewrite-and-replace)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )


(defun my-block-saving-in-org-mode ()
 "Prevent saving in Org mode."
 (when (eq major-mode 'org-mode)
   (error "Saving is blocked in Org mode")))

(defun enable-block-saving-in-org-mode ()
 "Enable blocking of saving in Org mode."
 (add-hook 'before-save-hook 'my-block-saving-in-org-mode))

(defun disable-block-saving-in-org-mode ()
 "Disable blocking of saving in Org mode."
 (remove-hook 'before-save-hook 'my-block-saving-in-org-mode))

(enable-block-saving-in-org-mode)
                                       ;https://github.com/rejeep/prodigy.el
;; (defun edit-config ()
;;   (find-file "~/.config/doom/config.el"))
;; )

;; ;;(global-set-key (kbd "C-!") 'eshell)
;; ;; (global-set-key (kbd "C-$") 'eshell)
;; ;; (global-set-key (kbd "C-^") 'eshell)
;; ;; (global-set-key (kbd "C-*") 'eshell)
;; ;; (global-set-key (kbd "C-)") 'eshell)
;; ;; (global-set-key (kbd "C-}") 'eshell)
;; ;; (global-set-key (kbd "C-\"") 'eshell)
;; ;; (global-set-key (kbd "C-,") 'eshell)
;; ;; (global-set-key (kbd "C-<") 'eshell)
;; ;; (global-set-key (kbd "C->") 'eshell)
;; ;; (global-set-key (kbd "C-#") 'eshell)
;; ;; (global-set-key (kbd "C-%") 'eshell)
;; ;; (global-set-key (kbd "C-&") 'eshell)
;; ;; (global-set-key (kbd "C-(") 'eshell)
;; ;; (global-set-key (kbd "C-{") 'eshell)
;; ;; (global-set-key (kbd "C-:") 'eshell)
;; ;; (global-set-key (kbd "C-|") 'eshell)
;; ;;https://discourse.doomemacs.org/t/why-is-emacs-doom-slow/83/3

;; (global-set-key (kbd "s-b") 'backward-word)

;; (global-set-key (kbd "C-c SPC") 'eshell)
;; (global-set-key (kbd "M-v") 'scroll-down-command)
;; (global-set-key (kbd "s-v") 'scroll-down-command)
;; (defun my-kill-region-or-backward-word ()
;;   "If a region is active and non-empty, kill the region. Otherwise, kill the word backward."
;;   (interactive)
;;   (if (use-region-p)
;;       (kill-region (region-beginning) (region-end))
;;     (backward-kill-word 1)))


;;   ;; (setq org-modern-star '("◉" "○" "◈" "◇" "*"))

;; ;; (setq
;; ;;  ;; Edit settings
;; ;;  org-auto-align-tags nil
;; ;;  org-tags-column 0
;; ;;  org-catch-invisible-edits 'show-and-error
;; ;;  org-special-ctrl-a/e t
;; ;;  org-insert-heading-respect-content t

;; ;;  ;; Org styling, hide markup etc.
;; ;;  org-hide-emphasis-markers t
;; ;;  org-pretty-entities t
;; ;;  org-ellipsis "…"

;; ;;  ;; Agenda styling
;; ;;  org-agenda-tags-column 0
;; ;;  org-agenda-block-separator ?─
;; ;;  org-agenda-time-grid
;; ;;  '((daily today require-timed)
;; ;;    (800 1000 1200 1400 1600 1800 2000)
;; ;;    " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
;; ;;  org-agenda-current-time-string
;; ;;  "⭠ now ─────────────────────────────────────────────────")

;; ;; ;; Global
;; ;; (global-org-modern-mode)




;; ;; (use-package! gptel
;; ;;   :config
;; ;;   (setq! gptel-api-key "sk-proj-Hmuqqnv6LyOuPwyoHwJgT3BlbkFJCeCujBnkIg9pAbO6K5rT")
;; ;;   )
;; ;;                                         ;List of models
;; ;;                                         ;
;; ;; ;; OPTIONAL configuration
;; ;; (setq
;; ;;  gptel-model "mistral:latest"
;; ;;  gptel-backend (gptel-make-ollama "Ollama"
;; ;;                  :host "localhost:11434"
;; ;;                  :stream t
;; ;;                  :models '("mistral:latest")))


;; ;; [
;; ;;  "Write the next paragraph",
;; ;;     "Continue writing the sentence",
;; ;;     "List key takeaways",
;; ;;     "Fix spelling and grammar",
;; ;;     "Write a short summary",
;; ;;     "Write a longer summary",
;; ;;     "Rephrase my writing",
;; ;;     "Simplify and condense my writing",
;; ;;     "Act as a copy editor",
;; ;;     "Suggest a few titles options",
;; ;;     "Suggest a few tweets based on my writing",
;; ;;     "Generate an outline for an article",
;; ;;     "Generate an overview for an article",
;; ;;     "Generate a counter argument",
;; ;;     "Generate an email",
;; ;;     "List action items",
;; ;;     "Write a blog post",
;; ;;     "Format paragraphs",
;; ;;     "Write analogies",
;; ;;     "Decorate my writing with backlinks",
;; ;;     "Super Summarizer",
;; ;;     "Points to document",
;; ;;     "Create a todo list"
;; ;; ]

;; ;; [
;; ;;     "Write with AI",
;; ;;     "Continue writing",
;; ;;     "Generate from page",
;; ;;     "Summarize",
;; ;;     "Find action items",
;; ;;     "Translate",
;; ;;     "Explain this",
;; ;;     "Edit or review page",
;; ;;     "Improve writing",
;; ;;     "Fix spelling & grammar",
;; ;;     "Make shorter",
;; ;;     "Make longer",
;; ;;     "Change tone",
;; ;;     "Simplify language",
;; ;;     "Draft with AI",
;; ;;     "Brainstorm ideas…",
;; ;;     "Blog post…",
;; ;;     "Outline…",
;; ;;     "Social media post…",
;; ;;     "Press release…",
;; ;;     "Creative story…",
;; ;;     "Essay…",
;; ;;     "See more",
;; ;;     "Insert AI blocks",
;; ;;     "Custom AI block"
;; ;; ]

;; ;; (use-package codeium
;; ;;   ;; if you use straight
;; ;;   ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
;; ;;   ;; otherwise, make sure that the codeium.el file is on load-path
;; ;;   :init
;; ;;   (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
;; ;;   :config
;; ;;   (setq use-dialog-box nil) ;; do not use popu
;; ;;   ;;
;; ;;   (setq codeium-mode-line-enable
;; ;;         (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
;; ;;   (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)

;; ;;   (setq codeium-api-enabled
;; ;;         (lambda (api)
;; ;;           (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
;; ;;   ;; you can also set a config for a single buffer like this:
;; ;;   ;; (add-hook 'python-mode-hook
;; ;;   ;;     (lambda ()
;; ;;   ;;         (setq-local codeium/editor_options/tab_size 4)))

;; ;;   ;; You can overwrite all the codeium configs!
;; ;;   ;; for example, we recommend limiting the string sent to codeium for better performance
;; ;;   (defun my-codeium/document/text ()
;; ;;     (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
;; ;;   ;; if you change the text, you should also change the cursor_offset
;; ;;   ;; warning: this is measured by UTF-8 encoded bytes
;; ;;   (defun my-codeium/document/cursor_offset ()
;; ;;     (codeium-utf8-byte-length
;; ;;      (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
;; ;;   (setq codeium/document/text 'my-codeium/document/text)
;; ;;   (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset)
;; ;;   )
;; ;; toggle side buffer on cmd-k
;; ;; @file, folder, code, @web, @docs, @lint, @git, @codebase
;; ;; chat history
;; ;; interpreter mode
;; ;; prompt minibuffer for instructionsx
;; ;;; if nothing selected,
;; ;;; generate here
;; ;;; if selection
;; ;;;   refactor selection
;; ;;https://emacsdocs.org/docs/elisp/Processes
;; ;;feel for the people that you dont
;; ;;  https://github.com/copilot-emacs/copilot.el?tab=readme-ov-file
;; ;;https://github.com/ahyatt/emacs-websocket
;; ;;https://github.com/tkf/emacs-request
;; ;;https://github.com/kiwanami/emacs-deferred
;; ;;; technologoies with the power to imprss women
;; ;;; robotics - cordy
;; ;;; advanced LLM usage - funny jokes, memes, art - robotic planning
;; ;;; image generation

;; ;;; porn search engine
;; ;;; voledemory fell from grace, because he shattered his psyche. he feared death.
;; ;;; before that, he was just kinda a weird kid who probably needed to go out side a little more.
;; ;;; shortens youtube videos
;; ;;;  SendGrid - SendGrid's Go library for sending email.
;; ;;;  https://awesome-go.com/advanced-console-uis/
;; ;;;  https://awesome-go.com/build-automation/
;; ;;;  https://github.com/sirupsen/logrus

;; ;;; agentic automation - bumble / events discovery
;; ;;; the Frozen Flame - paradox.
;; ;;; "What was the start of all this? When did the cogs of fate begin to turn? Perhaps it is impossible to grasp that answer now, from deep within the flow of time..."
;; ;;;steins gatree
;; ;;;mirai nikki
;; ;;;death note
;; ;;;https://en.wikipedia.org/wiki/Prediction
;; ;;;https://en.wikipedia.org/wiki/Eternalism_(philosophy_of_time)
;; ;;;https://en.wikipedia.org/wiki/Awareness
;; ;;;https://en.wikipedia.org/wiki/Tao
;; ;;;https://en.wikipedia.org/wiki/Siddhartha_(novel)
;; ;;;great change will occur through you
;; ;;;https://en.wikipedia.org/wiki/Macbeth
;; ;;;In War and Peace, Leo Tolstoy wrote of the 'unconscious swarm-life of mankind', while Shakespeare spoke of a 'tide in the affairs of men' in his play Julius Caesar.
;;                                         ;https://tvtropes.org/pmwiki/pmwiki.php/Characters/MarvelComicsMagneto
;; ;;"I am no hero. Merely a man who has seen and done and endured what can never be forgotten or forgiven."
;;                                         ;Only my actions... what I do in the name of all mutants... hold any real meaning."
;;                                         ;
;;                                         ;actions hace meaning, words do not
;;                                         ;https://en.wikipedia.org/wiki/Will_to_power
;;                                         ;https://en.wikipedia.org/wiki/Free_will
;;                                         ;https://tvtropes.org/pmwiki/pmwiki.php/Quotes/TimeMaster
;;                                         ;"...Heed my words. I am Malenia, Blade of Miquella. And I have never known defeat."

;;                                         ;https://tvtropes.org/pmwiki/pmwiki.php/Main/TheAtoner
;; ;;use GPT-0 to create training data for qwen2, cotinously efery sdefond?
;; ;;how much bandwith
;; ;;why did i spend 7 hours doing nothing
;; ;;SMH
;; ;;He who controls the past commands the future. He who commands the future, conquers the past.
;; ;;perception + detection
;; ;;jensesn huang,
;; ;;start time, uptime, utilziation
;; ;;
















;; ;;valdman, palmer luckey, tom preston werner, jesse , bret victor, and many more

;; ;; homelab / emacs / ff
;; ;;;

;; ;;; see activations - valdman
;; ;;;

;; ;; organize - mvp
;; ;; WEB RTC  ' RTSP / PIXEL STREAM UNREAL TODAY
;; ;; sqlite + ?
;; ;; nix ops ?https://tvtropes.org/pmwiki/pmwiki.php/Main/AntiVillain
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/UtopiaJustifiesTheMeans
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/WellIntentionedExtremist
;; ;; Safety in Indifference, Hope Is Scary
;; ;; i never beleieved in anything, just you
;; ;; In psychology, this trait is called "resilience". People who are very resilient can come back from major losses and get through extremely tough times without permanent effects.

;;                                         ; https://tvtropes.org/pmwiki/pmwiki.php/Main/Determinator
;; ;; resillient, rate of learning, action
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/HeroicResolve
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/WorthLivingFor
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/HopeIsScary
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/HeroicWillpower
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/DespairEventHorizon/AnimeAndManga
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Main/WoobieDestroyerOfWorlds
;; ;; https://tvtropes.org/pmwiki/pmwiki.php/Heartwarming/DeusExHumanRevolution
;; ;;
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/VideoGame/DeusEx
;; ;;thou mayest
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/DeusEstMachina
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/PrescienceIsPredictable
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/ScrewDestiny
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/MadOracle
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/YouCannotChangeTheFuture
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/Foreshadowing
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/XanatosSpeedChess
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Literature/Revan
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/YouAlreadyChangedThePast?from=Main.YouCannotChangeTheFuture
;; ;;Augury
;; ;;https://warhammer40k.fandom.com/wiki/Ahriman#Personality
;; ;;https://warhammer40k.fandom.com/wiki/Magnus_the_Red


;; ;;(add-to-list 'load-path "/Users/shelbernstein/,config/doom/adnan")
;; ;;(require 'pau)
;; ;;(load "pau")
;; ;;; ../Dot-files/doom/pau.el -*- lexical-binding: t; -*-
;; ;;https://github.com/rougier/nano-emacs
;; ;;https://github.com/playwright-community/playwright-go

;; ;; curl https://api.openai.com/v1/chat/completions   -H "Content-Type: application/json"   -H "Authorization: Bearer $OPENAI_API_KEY"   -d '{
;; ;;     "model": "gpt-3.5-turbo",
;; ;;     "messages": [
;; ;;       {
;; ;;         "role": "system",
;; ;;         "content": "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."
;; ;;       },
;; ;;       {
;; ;;         "role": "user",
;; ;;         "content": "Compose a poem that explains the concept of recursion in programming."
;; ;;       }
;; ;;     ]
;; ;;   }'

;; ;;k-proj-Hmuqqnv6LyOuPwyoHwJgT3BlbkFJCeCujBnkIg9pAbO6K5rT

;; ;; we recommend using use-package to organize your init.el
;; ;; (use-package codeium
;; ;;     ;; if you use straight
;; ;;     ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
;; ;;     ;; otherwise, make sure that the codeium.el file is on load-path

;; ;;     :init
;; ;;     ;; use globally
;; ;;     (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
;; ;;     ;; or on a hook
;; ;;     ;; (add-hook 'python-mode-hook
;; ;;     ;;     (lambda ()
;; ;;     ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

;; ;;     ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
;; ;;     ;; (add-hook 'python-mode-hook
;; ;;     ;;     (lambda ()
;; ;;     ;;         (setq-local completion-at-point-functions
;; ;;     ;;             (list (cape-super-capf #'codeium-completion-at-point #'lsp-completion-at-point)))))
;; ;;     ;; an async company-backend is coming soon!
;; ;;   }'
;; ;;     ;; codeium-completion-at-point is autoloaded, but you can
;; ;;     ;; optionally set a timer, which might speed up things as the
;; ;;     ;; codeium local language server takes ~0.2s to start up
;; ;;     ;; (add-hook 'emacs-startup-hook
;; ;;     ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

;; ;;     ;; :defer t ;; lazy loading, if you want
;; ;;     :config
;; ;;     (setq use-dialog-box nil) ;; do not use popup boxes

;; ;;     ;; if you don't want to use customize to save the api-key
;; ;;     ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

;; ;;     ;; get codeium status in the modeline
;; ;;     (setq codeium-mode-line-enable
;; ;;         (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
;; ;;     (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
;; ;;     ;; alternatively for a more extensive mode-line
;; ;;     ;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

;; ;;     ;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
;; ;;     (setq codeium-api-enabled
;; ;;         (lambda (api)
;; ;;             (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
;; ;;     ;; you can also set a config for a single buffer like this:
;; ;;     ;; (add-hook 'python-mode-hook
;; ;;     ;;     (lambda ()
;; ;;     ;;         (setq-local codeium/editor_options/tab_size 4)))

;; ;;     ;; You can overwrite all the codeium configs!
;; ;;     ;; for example, we recommend limiting the string sent to codeium for better performance
;; ;;     (defun my-codeium/document/text ()
;; ;;         (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
;; ;;     ;; if you change the text, you should also change the cursor_offset
;; ;;     ;; warning: this is measured by UTF-8 encoded bytes
;; ;;     (defun my-codeium/document/cursor_offset ()
;; ;;         (codeium-utf8-byte-length
;; ;;             (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
;; ;;     (setq codeium/document/text 'my-codeium/document/text)
;; ;;     (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset))

;; ;; (use-package company
;; ;;     :defer 0.1
;; ;;     :config
;; ;;     (global-company-mode t)
;; ;;     (setq-default
;; ;;         company-idle-delay 0.05
;; ;;         company-require-match nil
;; ;;         company-minimum-prefix-length 0

;; ;;         ;; get only preview
;; ;;         company-frontends '(company-preview-frontend)
;; ;;         ;; also get a drop down
;; ;;         ;; company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)
;; ;;         ))
;; ;;   }'

;; ;;use any text buffer on your computer as an emacs buffer -> forgot how
;; ;;
;; ;;
;; ;;
;;                                         ;* RETOOL
;;                                         ;* CUSTOMER.io
;;                                         ;https://developer.hashicorp.com/vagrant/tutorials/getting-started
;;                                         ;https://github.com/bregman-arie/devops-exercises/tree/master?tab=readme-ov-file#virtualization
;;                                         ;https://github.com/machyve/xhyve
;; ;; neural network plumbing
;; ;; DOOMEMACS and DevOps Tutor
;; ;; Ycombinator - BUSINESS = talking to USERS - UI/UX/TOOLS
;; ;; NixOSGuide
;; ;; PhD in BioTech and RObotics - DR Vegapunk
;; ;; 90 hours a week
;; ;; june, july,august
;; ;;
;; ;;
;; ;; -
;; ;; @vercel
;; ;;   hosting
;; ;; - Next.js / TypeScript: framework
;; ;; -
;; ;; @tailwindcss
;; ;; : CSS Framework
;; ;; -
;; ;; @shadcn
;; ;; : UX framework
;; ;; -
;; ;; @neondatabase
;; ;; : Serverless Postgres
;; ;; -
;; ;; @inngest
;; ;; : Messaging queue
;; ;; -
;; ;; @resendlabs
;; ;; : Transactional email
;; ;; -
;; ;; @stripe
;; ;; : Payments / Incorporation

;; ;;nix



;; ;; ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ;; ;; Place your private configuration here! Remember, you do not need to run 'doom
;; ;; ;; sync' after modifying this file!


;; ;; ;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; ;; ;; clients, file templates and snippets. It is optional.
;; ;; ;; (setq user-full-name "John Doe"
;; ;; ;;       user-mail-address "john@doe.com")

;; ;; ;; Doom exposes five (optional) variables for controlling fonts in Doom:
;; ;; ;;
;; ;; ;; - `doom-font' -- the primary font to use
;; ;; ;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; ;; ;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;; ;; ;;   presentations or streaming.
;; ;; ;; - `doom-symbol-font' -- for symbols
;; ;; ;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;; ;; ;;
;; ;; ;; See 'C-h v doom-font' for documentation and more examples of what they
;; ;; ;; accept. For example:
;; ;; ;;
;; ;; ;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;; ;; ;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; ;; ;;
;; ;; ;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; ;; ;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; ;; ;; refresh your font settings. If Emacs still can't find your font, it likely
;; ;; ;; wasn't installed correctly. Font issues are rarely Doom issues!

;; ;; ;; There are two ways to load a theme. Both assume the theme is installed and
;; ;; ;; available. You can either set `doom-theme' or manually load a theme with the
;; ;; ;; `load-theme' function. This is the default:
;; ;; (setq doom-theme 'doom-one)

;; ;; ;; This determines the style of line numbers in effect. If set to `nil', line
;; ;; ;; numbers are disabled. For relative line numbers, set this to `relative'.
;; ;; (setq display-line-numbers-type t)

;; ;; ;; If you use `org' and don't want your org files in the default location below,
;; ;; ;; change `org-directory'. It must be set before org loads!
;; ;; (setq org-directory "~/org/")


;; ;; ;; Whenever you reconfigure a package, make sure to wrap your config in an
;; ;; ;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;; ;; ;;
;; ;; ;;   (after! PACKAGE
;; ;; ;;     (setq x y))
;; ;; ;;
;; ;; ;; The exceptions to this rule:
;; ;; ;;
;; ;; ;;   - Setting file/directory variables (like `org-directory')
;; ;; ;;   - Setting variables which explicitly tell you to set them before their
;; ;; ;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;; ;; ;;   - Setting doom variables (which start with 'doom-' or '+').
;; ;; ;;
;; ;; ;; Here are some additional functions/macros that will help you configure Doom.
;; ;; ;;
;; ;; ;; - `load!' for loading external *.el files relative to this one
;; ;; ;; - `use-package!' for configuring packages
;; ;; ;; - `after!' for running code after a package has loaded
;; ;; ;; - `add-load-path!' for adding directories to the `load-path', relative to
;; ;; ;;   this file. Emacs searches the `load-path' when you load packages with
;; ;; ;;   `require' or `use-package'.
;; ;; ;; - `map!' for binding new keys
;; ;; ;;
;; ;; ;; To get information about any of these functions/macros, move the cursor over
;; ;; ;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; ;; ;; This will open documentation for it, including demos of how they are used.
;; ;; ;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; ;; ;; etc).
;; ;; ;;
;; ;; ;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; ;; ;; they are implemented
;; ;;
;; ;; Motion Planning
;; ;; Networking
;; ;; Infrastructure
;; ;; Perception
;; ;; Prediction
;; ;; gambling / probabalistic programming
;; ;;
;; ;;;;(global-set-key "\C-c" (lambda () (interactive) (find-file "~/Documents/fortress_of_solitude/2024-04-19\ -\ launch.md ")))





;;                                         ;(global-set-key "\C-x\C-k" 'kill-region)
;;                                         ;(global-set-key "\C-c\C-k" 'kill-region)

;; ;; (defun my-kill-region-or-backward-word ()
;; ;;   "If a region is active and non-empty, kill the region. Otherwise, kill the word backward."
;; ;;   (interactive)
;; ;;   (if (use-region-p)
;; ;;       (kill-region (region-beginning) (region-end))
;; ;;     (backward-kill-word 1)))
;; ;; (global-set-key "\C-w" 'my-kill-region-or-backward-word)
;; ;; (after! org
;; ;;   (setq org-agenda-deadline-leaders
;; ;;           '("" "" "%2d d. ago: ")
;; ;;         org-deadline-warning-days 0
;; ;;         org-agenda-span 7
;; ;;         org-agenda-start-day "-0d"
;; ;;         org-agenda-skip-function-global
;; ;;           '(org-agenda-skip-entry-if 'todo 'done)
;; ;;         org-log-done 'time)
;; ;; )



;; ;; (defun open-markdown-as-org ()
;; ;;   "Open Markdown files as Org mode."
;; ;;   (when (string-equal (file-name-extension buffer-file-name) "md")
;; ;;     (org-mode)))
;; ;; (add-to-list 'auto-mode-alist '("\\.md\\'" . open-markdown-as-org))
;; ;; (defun meta-s-keybind()
;; ;;   "If a region is active and non-empty, kill the region. Otherwise, kill the word backward."
;; ;;   (interactive)
;; ;;   (if (use-region-p)
;; ;;       (kill-regiion-save (region-beginning) (region-end))
;; ;;     (+workspace/close-window-or-workspace)))

;; ;;      https://github.com/minad/corfu?tab=readme-ov-file



;; ;;apheleia for code formatting via prettier https://github.com/radian-software/apheleia
;; ;;https://github.com/purcell/envrc
;; ;;add-node-modules-to-path https://github.com/codesuki/add-node-modules-path
;; ;;js-ts-mode, typescript-ts-mode, tsx-ts-mode via treesit-auto - https://github.com/renzmann/treesit-auto
;; ;;eglot w/ tsserver
;; ;;tide mode?
;; ;;https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/
;; ;;Emacs 29, tsx-ts-mode, eglot, flymake, flymake-eslint (not eslint-flymake)

;; ;;https://old.reddit.com/r/emacs/comments/thll06/ann_tsxmodeel_a_batteriesincluded_major_mode_for/
;; ;;I use jtsx-tsx-mode of jtsx package (I wroke it recently) + eglot. - https://github.com/llemaitre19/jtsx
;; ;;
;; ;;
;; ;;https://github.com/doomemacs/doomemacs/issues/6172
;; ;;
;; ;;
;; ;;
;; ;; (use-package! tsx-mode
;; ;;   :config
;; ;;   (setq auto-mode-alist (delete '("\\.tsx\\'" . typescript-tsx-mode) auto-mode-alist))
;; ;;   (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-mode))
;; ;;   (set-formatter! 'tsx-prettier '("prettier" "--parser" "typescript") :modes '(tsx-mode)))
;; ;;https://github.com/doomemacs/doomemacs/issues/6172
;; ;;https://medium.com/@nedopaka/setup-a-react-vite-project-with-typescript-prettier-vitest-2024-9bb6e919ac8f
;; ;;
;; ;;
;; ;;
;; ;;
;; ;;
;; ;;6:30 - wake up
;; ;;7:00 must leave house
;; ;;7:15 get to lifetime
;; ;;leave lifetime at 8
;; ;;815

;;                                         ;(global-set-key "\M-b" 'backward-kill-word)
;; ;; Automatically open all Markdown files as Org files


;; ;;typescript + web
;; ;;nix
;; ;;
;; ;;GO dev
;; ;;C++ dev
;; ;;;;android + kotlin ? lol

;;                                         ;https://www.reddit.com/r/emacs/comments/13god8v/how_do_i_improve_emacs_as_a_typescript_ide/
;; ;;https://www.reddit.com/r/emacs/comments/13z8i1a/typescript_highlighting_in_emacs_incomplete/
;; ;;https://www.reddit.com/r/emacs/comments/mgbejx/webmacs_new_emacs_configuration_for_web/
;; ;; (global-set-key [(meta v)] 'revert-buffer-no-confirm) ;
;; ;; (global-set-key [(meta o)] 'goto-line)
;; ;; (global-set-key (kbd "M-p") 'iswitchb-buffer)
;; ;; (global-set-key (kbd "M-i") 'gofmt)


;;                                         ;https://news.ycombinator.com/item?id=9600106
;; ;;https://github.com/WeAreWizards/blog/blob/master/content/articles/ansible-and-nix.md
;; ;;
;; ;;
;; ;;LSP mode - tailwind ??
;; ;;prettier.js



;;                                         ;(add-to-list 'auto-mode-alist '("\\.jsx?$" . rjsx-mode))
;;                                         ;(add-to-list 'auto-mode-alist '("\\.tsx?$" . typescript-mode))


;; ;;; Setup TypeScript Interactive Development Environment
;; ;; (defun setup-tide-mode ()
;; ;;   (interactive)
;; ;;   (tide-setup)
;; ;;   (flycheck-mode +1)
;; ;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;; ;;   (eldoc-mode +1)
;; ;;   (tide-hl-identifier-mode +1)
;; ;;   (company-mode +1))

;; ;; (add-hook 'typescript-mode-hook #'setup-tide-mode)
;; ;; (add-hook 'js2-mode-hook #'setup-tide-mode)
;; ;; (add-hook 'rjsx-mode-hook #'setup-tide-mode)


;; ;;init.el
;;                                         ;:lang
;; ;;(prettier +onsave)
;;                                         ;(typescript +lsp)
;;                                         ;:lang
;;                                         ;(web +lsp)
;;                                         ;
;; ;;;emmet mode?
;; ;;https://zzamboni.org/post/my-doom-emacs-configuration-with-commentary/
;;                                         ;describe bindings
;;                                         ;
;; ;;;; free-keys.el --- Show free keybindings for modkeys or prefixes

;; ;; Copyright (C) 2013 Matus Goljer

;; ;; Author: Matus Goljer <matus.goljer@gmail.com>
;; ;; Maintainer: Matus Goljer <matus.goljer@gmail.com>
;; ;; Version: 1.0
;; ;; Created: 3rd November 2013
;; ;; Keywords: convenience
;; ;; Package-Requires: ((cl-lib "0.3"))
;; ;; URL: https://github.com/Fuco1/free-keys

;; ;; This file is not part of GNU Emacs.


;; ;; This program is free software; you can redistribute it and/or modify
;; ;; it under the terms of the GNU General Public License as published by
;; ;; the Free Software Foundation, either version 3 of the License, or
;; ;; (at your option) any later version.

;; ;; This program is distributed in the hope that it will be useful,
;; ;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; ;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; ;; GNU General Public License for more details.

;; ;; You should have received a copy of the GNU General Public License
;; ;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; ;;; Commentary:

;; ;; Show free keybindings for modkeys or prefixes. Based on code
;; ;; located here: https://gist.github.com/bjorne/3796607
;; ;;
;; ;; For complete description see https://github.com/Fuco1/free-keys

;; ;;; Code:



;; ;; With modifier C (18 free)
;; ;; =========================
;; ;; C-!     C-$     C-^     C-*     C-)     C-}     C-"     C-,     C-<     C->
;; ;; C-#     C-%     C-&     C-(     C-{     C-:     C-|     C-.

;; ;; With modifier M (33 free)
;; ;; =========================
;; ;; M-n     M-B     M-F     M-J     M-M     M-P     M-S     M-V     M-Z     M-[
;; ;; M-o     M-C     M-G     M-K     M-N     M-Q     M-T     M-W     M-#     M-]
;; ;; M-p     M-D     M-H     M-L     M-O     M-R     M-U     M-Y     M-*     M-"
;; ;; M-A     M-E     M-I

;; ;; With modifier C-M (30 free)
;; ;; =========================
;; ;; C-M-g     C-M-G     C-M-!     C-M-&     C-M-=     C-M-;     C-M-|     C-M-?
;; ;; C-M-m     C-M-M     C-M-#     C-M-*     C-M-]     C-M-'     C-M-<     C-M-`
;; ;; C-M-y     C-M-Y     C-M-$     C-M-(     C-M-{     C-M-:     C-M->     C-M-~
;; ;; C-M-z     C-M-Z     C-M-^     C-M-)     C-M-}     C-M-"


;; ;;Cmd-L


;; ;; (global-set-key (kbd "C-!") 'eshell)
;; ;; (global-set-key (kbd "C-$") 'eshell)
;; ;; (global-set-key (kbd "C-^") 'eshell)
;; ;; (global-set-key (kbd "C-*") 'eshell)
;; ;; (global-set-key (kbd "C-)") 'eshell)
;; ;; (global-set-key (kbd "C-}") 'eshell)
;; ;; (global-set-key (kbd "C-\"") 'eshell)
;; ;; (global-set-key (kbd "C-,") 'eshell)
;; ;; (global-set-key (kbd "C-<") 'eshell)
;; ;; (global-set-key (kbd "C->") 'eshell)
;; ;; (global-set-key (kbd "C-#") 'eshell)
;; ;; (global-set-key (kbd "C-%") 'eshell)
;; ;; (global-set-key (kbd "C-&") 'eshell)
;; ;; (global-set-key (kbd "C-(") 'eshell)
;; ;; (global-set-key (kbd "C-{") 'eshell)
;; ;; (global-set-key (kbd "C-:") 'eshell)
;; ;; (global-set-key (kbd "C-|") 'eshell)
;; ;; (global-set-key (kbd "C-.") 'eshell)



;; ;; (global-set-key (kbd "M-n") 'eshell)
;; ;; (global-set-key (kbd "M-B") 'eshell)
;; ;; (global-set-key (kbd "M-F") 'eshell)
;; ;; (global-set-key (kbd "M-J") 'eshell)
;; ;; (global-set-key (kbd "M-M") 'eshell)
;; ;; (global-set-key (kbd "M-P") 'eshell)
;; ;; (global-set-key (kbd "M-S") 'eshell)
;; ;; (global-set-key (kbd "M-V") 'eshell)
;; ;; (global-set-key (kbd "M-Z") 'eshell)
;; ;; (global-set-key (kbd "M-[") 'eshell)
;; ;; (global-set-key (kbd "M-o") 'eshell)
;; ;; (global-set-key (kbd "M-C") 'eshell)
;; ;; (global-set-key (kbd "M-G") 'eshell)
;; ;; (global-set-key (kbd "M-K") 'eshell)
;; ;; (global-set-key (kbd "M-N") 'eshell)
;; ;; (global-set-key (kbd "M-Q") 'eshell)
;; ;; (global-set-key (kbd "M-T") 'eshell)
;; ;; (global-set-key (kbd "M-W") 'eshell)
;; ;; (global-set-key (kbd "M-#") 'eshell)
;; ;; (global-set-key (kbd "M-]") 'eshell)
;; ;; (global-set-key (kbd "M-p") 'eshell)
;; ;; (global-set-key (kbd "M-D") 'eshell)
;; ;; (global-set-key (kbd "M-H") 'eshell)
;; ;; (global-set-key (kbd "M-L") 'eshell)
;; ;; (global-set-key (kbd "M-O") 'eshell)
;; ;; (global-set-key (kbd "M-R") 'eshell)
;; ;; (global-set-key (kbd "M-U") 'eshell)
;; ;; (global-set-key (kbd "M-Y") 'eshell)
;; ;; (global-set-key (kbd "M-*") 'eshell)
;; ;; (global-set-key (kbd "M-\"") 'eshell)
;; ;; (global-set-key (kbd "M-A") 'eshell)
;; ;; (global-set-key (kbd "M-E") 'eshell)
;; ;; (global-set-key (kbd "M-I") 'eshell)


;; ;; (global-set-key (kbd "C-M-g") 'eshell)
;; ;; (global-set-key (kbd "C-M-G") 'eshell)
;; ;; (global-set-key (kbd "C-M-!") 'eshell)
;; ;; (global-set-key (kbd "C-M-&") 'eshell)
;; ;; (global-set-key (kbd "C-M-=") 'eshell)
;; ;; (global-set-key (kbd "C-M-;") 'eshell)
;; ;; (global-set-key (kbd "C-M-|") 'eshell)
;; ;; (global-set-key (kbd "C-M-?") 'eshell)
;; ;; (global-set-key (kbd "C-M-m") 'eshell)
;; ;; (global-set-key (kbd "C-M-M") 'eshell)
;; ;; (global-set-key (kbd "C-M-#") 'eshell)
;; ;; (global-set-key (kbd "C-M-*") 'eshell)
;; ;; (global-set-key (kbd "C-M-]") 'eshell)
;; ;; (global-set-key (kbd "C-M-'") 'eshell)
;; ;; (global-set-key (kbd "C-M-<") 'eshell)
;; ;; (global-set-key (kbd "C-M-`") 'eshell)
;; ;; (global-set-key (kbd "C-M-y") 'eshell)
;; ;; (global-set-key (kbd "C-M-Y") 'eshell)
;; ;; (global-set-key (kbd "C-M-$") 'eshell)
;; ;; (global-set-key (kbd "C-M-(") 'eshell)
;; ;; (global-set-key (kbd "C-M-{") 'eshell)
;; ;; (global-set-key (kbd "C-M-:") 'eshell)
;; ;; (global-set-key (kbd "C-M->") 'eshell)
;; ;; (global-set-key (kbd "C-M-~") 'eshell)
;; ;; (global-set-key (kbd "C-M-z") 'eshell)
;; ;; (global-set-key (kbd "C-M-Z") 'eshell)
;; ;; (global-set-key (kbd "C-M-^") 'eshell)
;; ;; (global-set-key (kbd "C-M-)") 'eshell)
;; ;; (global-set-key (kbd "C-M-}") 'eshell)
;; ;; (global-set-key (kbd "C-M-\"") 'eshell)


;; ;; use usage statistics to determine which parts of emacs are legacy cruft


;; ;; (require 'json)
;; ;; (require 'cl-lib)
;; ;; (require 'url)

;; ;; (defgroup ollama nil
;; ;;   "Ollama client for Emacs."
;; ;;   :group 'ollama)
;; ;; ;;* POSIX Pipes or FIFOs:
;; ;; ;;how much is the ollama overhead
;; ;; ;;qwen2 deepseek-v2
;; ;; (defcustom ollama:endpoint "http://localhost:11434/api/generate"
;; ;;   "Ollama http service endpoint."
;; ;;   :group 'ollama
;; ;;   :type 'string)

;; ;; (defcustom ollama:model "llama2-uncensored"
;; ;;   "Ollama model."
;; ;;   :group 'ollama
;; ;;   :type 'string)

;; ;; (defcustom ollama:language "Chinese"
;; ;;   "Language to translate to."
;; ;;   :group 'ollama
;; ;;   :type 'string)

;; ;; (defun ollama-fetch (url prompt model)
;; ;;   (let* ((url-request-method "POST")
;; ;;          (url-request-extra-headers
;; ;;           '(("Content-Type" . "application/json")))
;; ;;          (url-request-data
;; ;;           (encode-coding-string
;; ;;            (json-encode `((model . ,model) (prompt . ,prompt)))
;; ;;            'utf-8)))
;; ;;     (with-current-buffer (url-retrieve-synchronously url)
;; ;;       (goto-char url-http-end-of-headers)
;; ;;       (decode-coding-string
;; ;;        (buffer-substring-no-properties
;; ;;         (point)
;; ;;         (point-max))
;; ;;        'utf-8))))

;; ;; (defun ollama-get-response-from-line (line)
;; ;;   (cdr
;; ;;    (assoc 'response
;; ;;           (json-read-from-string line))))

;; ;; (defun ollama-prompt (url prompt model)
;; ;;   (mapconcat 'ollama-get-response-from-line
;; ;;              (cl-remove-if #'(lambda (str) (string= str ""))
;; ;;                         (split-string (ollama-fetch url prompt model) "\n")) ""))

;; ;; ;;;###autoload
;; ;; (defun ollama-prompt-line ()
;; ;;   "Prompt with current word."
;; ;;   (interactive)
;; ;;   (with-output-to-temp-buffer "*ollama*"
;; ;;     (princ
;; ;;      (ollama-prompt ollama:endpoint (thing-at-point 'line) ollama:model))))

;; ;; ;;;###autoload
;; ;; (defun ollama-define-word ()
;; ;;   "Find definition of current word."
;; ;;   (interactive)
;; ;;   (with-output-to-temp-buffer "*ollama*"
;; ;;     (princ
;; ;;      (ollama-prompt ollama:endpoint (format "define %s" (thing-at-point 'word)) ollama:model))))

;; ;; ;;;###autoload
;; ;; (defun ollama-translate-word ()
;; ;;   "Translate current word."
;; ;;   (interactive)
;; ;;   (with-output-to-temp-buffer "*ollama*"
;; ;;     (princ
;; ;;      (ollama-prompt ollama:endpoint (format "translate \"%s\" to %s" (thing-at-point 'word) ollama:language) ollama:model))))

;; ;; ;;;###autoload
;; ;; (defun ollama-summarize-region ()
;; ;;    "Summarize marked text."
;; ;;   (interactive)
;; ;;   (with-output-to-temp-buffer "*ollama*"
;; ;;     (princ
;; ;;      (ollama-prompt ollama:endpoint (format "summarize \"\"\"%s\"\"\"" (buffer-substring (region-beginning) (region-end))) ollama:model))))

;; ;; //dhh+omakub@hey.com
;; ;; https://www.braintrust.dev/docs/guides/self-hosting
;; ;; His speech to Lorgar on/above Calth really made me love him, and see his character as a whole person, not just an armoured accountant.
;; ;; https://www.reddit.com/r/40kLore/comments/7jxfik/book_excerptknow_no_fear_guilliman_and_lorgar/?utm_source=share&utm_medium=ios_app&utm_name=iossmf
;; ;; I’m definitely held back by not having real performance tools like perf and eBPF.

;; ;; good voice acting -- comedy - pattern match transcript and funny quotes


;; ;; Labelbox

;; ;; Prodigy

;; ;; Supervisely

;; ;; Label Studio

;; ;; Scale AI

;; ;; Dataloop

;; ;; dreams of the future
;; ;; memories of the past
;; ;; spark of all paths and moments
;; ;; a life of diffrent rules, sacrificce
;; ;; the ultimate incarnation of causality and time and space
;; ;; does everything happpen for a reason
;; ;; what is the truth
;; ;; strategy, tactics,
;; ;; omniscience, clairvoyance, prediciton, planning,
;; ;; duty, erersponsbility and ethereal
;; ;; time magic
;; ;; mind magic - illusion
;; ;; divination congrol porbabiltiy and luck
;; ;; concentration, insight, focus, attention, intuition,
;; ;; will, comittment, and the ability to move
;; ;; Prescience
;; ;; Foreboding
;; ;; Scrier's
;; ;; the secret gage
;; ;; sanity rapidly degtrading
;; ;; density
;; ;; 3 words edit-tab-stops-buffer
;; ;; fate and hope
;; ;; fortune
;; ;; conspiracy
;; ;; articetcht of fate
;; ;; convolutions
;; ;; dreams and aspirations


;; ;; complexity addiction

;; ;;  constantly seeks to change, evolve, and discard old laws and restrictions in favour of making your own way based purely on your own will and vision.
;; ;;  Fateweaver, the Oracle

;; ;; everything i do is for zoox
;; ;; zooxo was the pinnacle of my life
;; ;; since i was , i just wanted to dhange the world, but i didnt know how

;; ;; most tencology companies dont really hange the world
;; ;; google, facebook, amazon, microsfott and apple, netflix  are literalyl 90% entertainment

;; ;; living embodiment of fate, change, and destiny
;; ;; a story that is still unfolding
;; ;; there can be no doubt
;; ;; absolute victroy
;; ;; the ultimate incarnation of causaality, a world of infinite possibilities
;; ;; the incarnation of

;; ;; //want to see multiple possiblities unfold at aonce


;; ;; plan - get job by july 21 - 7 weeks from now
;; ;; literally count 49 days
;; ;; august 20 is when school starts - go to ASU
;; ;; cant chagne the past
;; ;; consequcensc are irreverisible
;; ;; who could havec predited you
;; ;; naruto best quotes
;; ;; threads of fate
;; ;; providecnce
;; ;; divination
;; ;; wish
;; ;;
;; ;;https://tvtropes.org/pmwiki/pmwiki.php/Main/SpannerInTheWorks
;; ;;
;; ;;bend the arc of time
;; ;;steins gate
;; ;;future diary
;;                                         ;Transcendence
;;                                         ;https://en.wikipedia.org/wiki/Causality_(physics);;"To know sorrow is not terrifying. What is terrifying is to know you can't go back to happiness you could have."
;;                                          ;
;;                                         ;
;;                                         ;time magic
;;                                         ;illusion magic
;;                                         ;https://en.wikipedia.org/wiki/Closed_timelike_curve
;;                                         ;repercussions
;;                                         ;irreverisble
;;                                         ;causality
;;                                         ;convergence
;;                                         ;https://en.wikipedia.org/wiki/The_Rise_and_Fall_of_D.O.D.O.
;;                                         ;paradox
;;                                         ;tautology
;;                                         ;minority report - precog
;;                                         ;avalanche
;;                                         ;chain reaxtion
;;                                         ;dominoes
;;                                         ;
;;                                         ;https://en.wikipedia.org/wiki/Representativeness_heuristic
;;                                         ;riples
;;                                         ;snowball
;;                                         ;traffic congestion
;;                                         ;nowba
;;                                         ;https://en.wikipedia.org/wiki/Chain_reaction
;;                                         ;https://en.wikipedia.org/wiki/Domino_effect
;;                                         ;https://en.wikipedia.org/wiki/Mathematical_induction
;;                                         ;systemds thinkfing
;;                                         ;https://en.wikipedia.org/wiki/Dynamical_system
;;                                         ;https://en.wikipedia.org/wiki/Positive_feedback
