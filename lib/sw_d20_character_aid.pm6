use v6;
use Grammar::Tracer::Compact;

class SWCA::Skill {
    has $.name;
    has $.attribute;
    has %.modifiers;
    has %.classes;

    method new($name, $attribute, %modifiers, %classes) {
        self.bless(:$name, :$attribute, :%modifiers, :%classes);
    }
}

grammar SWCA::Skill::Grammar {
    token modifier { "Untrained" | "Force" }
    token attribute { '(' \w ** 3 ')' }
    token name { [\w+]+ % \h+ }
    token first-line { ^^ <name> \h+ <attribute> [\h+ <modifier>* % [\h+]]? $$ }
    token second-line { ^^ <name>+ % [ \h* ',' \h* ] $$ }
    token skill { <first-line> \h* \v \h* <second-line> }
    token TOP { <skill>+ % [ \v \s+ ] \s* }
}

class SWCA::Skill::Actions {
    method skill($/) {
        my %modifiers;
        for @($/<first-line><modifier>) -> $mod {
            %modifiers{$mod} = 1;
        }
        dd %modifiers;

        my %classes;
        for @($/<second-line><name>) -> $class {
            %classes{$class} = 1;
        }
        dd %classes;

        make SWCA::Skill.new(~$/<first-line><name>,
                $/<first-line><attribute>.substr(1, 3),
                %modifiers,
                %classes);
    }
}

class SWCA::Character {
    has %.stat;
    has %.skill-ranks;
}

grammar SWCA::Character::Grammar {
    token attribute-name { 'Str' | 'Int' | 'Wis' | 'Dex' | 'Con' | 'Chr' }
    token attribute-score { \d+ }
    token attribute { <attribute-name> \h* ':' \h* <attribute-score> }

    token name { [\w+]+ % \h+ }
    token ranks { \d+ }
    token skill-rank { <name> \h* ':' \h* <ranks> }

    token TOP { [<attribute> \v] ** 6 \v* <skill-rank>+ % \v \s* }
}

class SWCA::Character::Actions {
    method TOP($/) {
        my %stat;
        for @($/<attribute>) -> $stat {
            %stat{$stat<attribute-name>} = +$stat<attribute-score>;
        }
        dd %stat;

        my %skill-ranks;
        for @($/<skill-rank>) -> $skill {
            %skill-ranks{$skill<name>} = +$skill<ranks>;
        }
        dd %skill-ranks;

        make SWCA::Character.new(:%stat, :%skill-ranks);
    }
}

