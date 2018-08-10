use v6;
use Grammar::Tracer::Compact;


grammar SWCA::Skill {
    token modifier { "Untrained" | "Force" }
    token attribute { '(' \w ** 3 ')' }
    token name { [\w+]+ % \h+ }
    token first-line { ^^ <name> \h+ <attribute> [\h+ <modifier>* % [\h+]]? $$ }
    token second-line { ^^ <name>+ % [ \h* ',' \h* ] $$ }
    token skill { <first-line> \h* \v \h* <second-line> }
    token TOP { <skill>+ % [ \v \s+ ] \s* }
}

