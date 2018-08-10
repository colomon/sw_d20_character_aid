use v6;
# use Grammar::Tracer::Compact;


grammar SWCA::Skill {
    token modifier { "Untrained" | "Force" }
    token attribute { '(' \w ** 3 ')' }
    token name { [\w+]+ % \s+ }
    token first-line { ^^ <name> \h+ <attribute> [\h+ <modifier>* % [\h+]]? $$ }
    rule second-line { ^^ <name>+ % [ \s* ',' \s* ] $$ }
    rule skill { <first-line> <second-line> }
}

