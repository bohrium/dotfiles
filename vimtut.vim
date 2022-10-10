"   author: sam tenka
"   change: 2022-09-30
"   create: 2018-09-01
"   descrp: Basic vim tutorial in case my muscle memory deteriorates
"           NOTE: unfinished!
"   jargon:
"   thanks:
"   to use:

"==============================================================================
"=  COMMANDS SYNPOSIS  ========================================================
"==============================================================================

"  https://www.worldtimzone.com/res/vi.html

" In what follows, the backtick, square brackets, and pipe are special.  Each
" non-empty all-caps substring wrapped by backticks is to be substituted by
" a special substring, whether the latter be a modifier character
" (control(`CTL`), meta/alt(`ALT`), escape(`ESC`), delete(`DEL`),
" backspace(`BCK`), enter(`NEW`)) or some user-specified choice (e.g. file
" name(`FILENM`), shell command(`COMMAND`), line number(`LN`), vim search
" pattern(`PATTERN`)).  We press characters written after `CTL` or `ALT` at
" the same time as that modifier character.  We pretend that we can produce
" each uppercase character by pressing some single logical key dedicated to
" that uppercase character rather than by using (`shift` or `capslock`) ---
" this logical key's correspondence to multiple physical keys is a hardware
" rather than a software concern.



"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Minimal Knowledge  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



"--  lesson 0.0 on "modes"  ---------------------------------------------------

" Fire up vim by running `vim` in a command line while also keeping this
" tutorial open elsewhere for reference.  Press these 9 keys in sequence
" (colon, e, space, h, a, l, l, o, enter):
"
"   :e hallo`NEW`
"
" Now press this single key (i):
"
"   i
"
" Now press these 17 keys (h, e, l, l, o, colon, space, g, o, o, d, space,
" w, o, r, l, l, d):
"
"   hello: good worlld
"
" Oops!  We misspelled /world/.  Fix this by pressing these 2 keys (left-arrow,
" backspace):
"
"   `LEFT``BCK`
"
" Now press this single key (escape):
"
"   `ESC`
"
" Now press these 3 keys (colon, x, enter):
"
"   :x`NEW`
"
" Here we learned about "modes".  We started --- as we always do --- in
" "normal" mode.  Normal mode parses commands such as `:e` (for editing a
" specified file) and `:x` (for closing a file we are editing).  The example
" above used both those commands as bookends around an actual editing session.
" In this case, our editing session just consisted of writing some text into
" the file.
"
" To write text to our file, we'd like to literally translates keystrokes into
" file-insertions.  Normal mode interprets characters such as `:` literally,
" so it won't do.   We instead switch to "insert" mode.  We used `i` and ``ESC``
" to switch from normal to insert mode and back.  In insert mode, we simply
" type the text we want to add.
"
" Here, in summary, are what the above six keysequences do:
"
"   :e hallo`NEW`       -- open `hallo` for editing, creating it if needed
"   i                   -- switch from normal to insert mode
"   hello: good worlld  -- insert this salutation to the current file
"   `LEFT``BCK`         -- delete letter before previous letter
"   `ESC`               -- switch from insert to normal mode
"   :x`NEW`             -- close current file, saving it if needed
"
" That's nice.  You might now wonder why we have any mode besides insert mode.
" Is normal mode more than just cumbersome scaffolding?  The next paragraph
" offers a glimpse into the point of non-insert modes.



"--  lesson 0.1 on "commands"  ------------------------------------------------

" Let's continue editing that file.  Use `vim` to open the file `hallo`.  You
" can do this by using `:e` as described above OR by providing `vim` with
" `hallo` as a command line argument.  Now press these 5 keys (w, w, v,
" dollar, U):
"
"   wwv$U
"
" Now press these 5 keys (0, v, w, y, P):
"
"   0vwyP
"
" Now close-and-save the file by using `:x` as described above.
"
" Here we met some `commands` available in non-insert modes.  The first
" command, `wwv$U`, literally translates to
"
"  `w` -- jump to the next word (counting punctation as a delimiter)
"  `w` -- jump to the next word (counting punctation as a delimiter)
"  `v` -- start selecting text (technically, we go to visual selection mode)
"  `$` -- jump to the line's end
"  `U` -- make the selection entirely uppercase
"
" When we jump within "visual selection" mode, our selection will expand with
" the jump.  Thus
"
"   hallo: good world
"
" becomes
"
"   hallo: GOOD WORLD
"
" The second command, `0vwyP`, translates to
"
"  `0` -- jump to the line's start
"  `v` -- start selecting text (technically, we go to visual selection mode)
"  `w` -- jump to the next word (counting punctuation as a delimiter)
"  `y` -- yank (copy) the selection and return to normal mode
"  `P` -- paste (whatever is yanked (copied)) to place before cursor
"
" Thus
"   hallo: GOOD WORLD
" becomes
"   hallo:hallo: GOOD WORLD
"
" The two commands share structure: the prefixes `wwv$` and `0vw` prepare an
" object --- a region of text --- on which we act.  The suffixes `U` and `yP`
" specify the action.  That the two commands each have a verb and an object is
" typical of vim.  We will encounter grammatical forms that go verb-object
" instead of object-verb as well.  That commands can operate on structures
" more meaningful than mere characters --- words, parenthesized expressions,
" lines, paragraphs, code blocks --- is one reason why they are so useful
" and why we therefore want modes beyond insert mode.



"--  lesson 0.2 summarizing how to use-but-not-utilize vim  -------------------

" The left column, a subsequence of "NVI -> NVI", indicates which modes the
" command is valid in and which modes the command moves us to.  For example,
" "VI -> N" means the command works in both visual or insert mode and that
" after the command runs we are in normal mode.  An empty target means that
" we stay in the same mode.  The following spec DOES NOT show the full power
" of commands such as `y`.
"
" "Commands" in "normal" and "visual" modes:
"
"   N   ->     |  :e `FILENM`     edit (create if necessary)
"   N   ->     |  :x              exit (save if necessary)
"
"   N   ->     |  P               paste whatever's yanked to place before cursor
"
"    V  -> N   |  d               delete-after-yanking selection
"    V  -> N   |  y               yank selection
"    V  ->     |  U               uppercase-ify selection
"    V  ->     |  u               lowercase-ify selection
"
" "Text insertion" in "insert" mode:
"
"     I ->     |  `PRINTABLE`     insert the specified printable char
"     I ->     |  `WHITESPACE`    insert the specified whitespace char
"
"     I ->     |  `DEL`           delete at cursor, which is then at next char
"     I ->     |  `BCK`           delete before the cursor
"
" "Navigation" in multiple modes:
"
"   NVI ->     |  `LEFT`          move cursor left
"   NVI ->     |  `RIGHT`         move cursor right
"   NVI ->     |  `UP`            move cursor up
"   NVI ->     |  `DOWN`          move cursor down
"
"   NV  ->     |  w               jump to next word's start; punctuation delimits
"   NV  ->     |  0               jump to line's start
"   NV  ->     |  $               jump to line's end
"
" "Switch" modes:
"
"   N   ->   I |  i               to insert mode
"    VI -> N   |  `ESC`           to normal mode (slight pause if visual->normal)
"   N   ->  V  |  v               to visual mode

" For some semblance of completeness, we have also included commands `u` (for
" lower-casing), `d` (for deleting-after-yanking), `DEL` (for deletion of the
" char after the cursor), and all four arrow keys.



"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Basic Knowledge  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"--  lesson 1.0 on verb-object form  ------------------------------------------

" "cut-paste"
"
"   [y|yy]          yank (double means do it to line)
"   [d|dd]          delete (double means do it to line)
"   [p|P]           paste after(`p`) or before (`P`) cursor
"
"   >               indent
"   <               unindent
"
" "case"
"
"   [u|U]           set case to lower(`u`) or upper(`U`)
"   ~               toggle case
"
" "history"
"
"   u               undo most recent command
"   `CTL`r          redo an undone command
"   .               repeat most recent command (do-verb-to-object) in N mode

" and useful vocabulary: useful verbs and objects

"--  lesson 1.1 listing useful object-specifying motions  ---------------------


"--  lesson 1.2 on working with modes  ----------------------------------------


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Basics  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"
"   :e `FILENM`     edit
"   :w              save
"   :q              exit
"   :x              after saving-if-modified, exit
"   :sav `FILENM`   save-as
"
"   :!`COMMAND`     execute bash command
"   !!`COMMAND`     execute bash command and append output to file
"
" The following all go from normal mode to a different mode:
"
"   [o|O]           insert mode at new line after(`o`) or before(`O`) cursor
"   `CTL`R          replace mode
"   `CTL`v          visual (columnar aka block) mode
"   i               insert mode
"   v               visual (linear) mode
"
" To go from a non-normal mode back to normal mode, simply escape:
"
"   `ESC`           normal mode

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Verb-Object Commands  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"   >               indent
"   <               unindent
"   [y|yy]          yank (double means do it to line)
"   [d|dd]          delete (double means do it to line)
"   [p|P]           paste after(`p`) or before (`P`) cursor
"
"   [u|U]           set case to lower(`u`) or upper(`U`)
"   ~               toggle case
"
"   u               undo most recent command (among commands not undone)
"   `CTL`r          redo an undone command
"   .               repeat most recent command (do-verb-to-object) in N mode

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Intra-text Navigation  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"   [b|B]           back to word start (lowercase: delimit at punctuation)
"   [e|E]           on   to word end   (lowercase: delimit at punctuation)
"   [w|W]           on   to word start (lowercase: delimit at punctuation)
"
"   0               line start
"   $               line end
"
"   {               paragraph start
"   }               paragraph end
"
"   H               screenful start
"   M               screenful middle
"   L               screenful end
"
"   gg              file start
"   G               file end
"
"   :`LN`           go to the indicated line number
"   `LN`G           go to the indicated line number
"
"   m`LETTER`       mark this position with the given letter
"   ``LETTER`       go to position marked with the given letter
"   ``              go back after marking operation

"   /`PATTERN`      search onward for pattern
"   /               search onward for last-searched pattern
"   ?               search back   for last-searched pattern

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Inter-text Navigation: Tabs, Windows, File Tree  ~~~~~~~~~~~~~~~~~~~~~~



