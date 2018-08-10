use v6;
# use Grammar::Tracer::Compact;


grammar SWCA::Skill {
    token modifier { "Untrained" | "Force" }
    token attribute { '(' \w ** 3 ')' }
    token name { [\w+]+ % \s+ }
    rule first-line { ^^ <name> <attribute> <modifier>* % [\s+] $$ }
    rule second-line { ^^ (.*?)+ % [ \s* ',' \s* ] }
}

