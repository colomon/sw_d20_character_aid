use sw_d20_character_aid;
use Test;

{
    my $match = SWCA::Skill::Grammar.parse('Appraise', :rule<name>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Appraise is valid first line';
    is $match, "Appraise", '... named Appraise';
}

{
    my $match = SWCA::Skill::Grammar.parse('Appraise (Int) Untrained', :rule<first-line>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Appraise is valid first line';
    is $match<name>, "Appraise", '... named Appraise';
    is $match<attribute>, "(Int)", '... based on Int';
    is $match<modifier>[0], "Untrained", '... and usuable untrained"';
}

{
    my $match = SWCA::Skill::Grammar.parse('Move Object', :rule<name>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Move Object is valid first line';
    is $match, "Move Object", '... named Move Object';
}

{
    my $match = SWCA::Skill::Grammar.parse('Move Object (Int) Force Untrained', :rule<first-line>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Move Object is valid first line';
    is $match<name>, "Move Object", '... named Move Object';
    is $match<attribute>, "(Int)", '... based on Int';
    is $match<modifier>[0], "Force", '... a force skill"';
    is $match<modifier>[1], "Untrained", '... and usuable untrained"';
}

{
    my $match = SWCA::Skill::Grammar.parse('Astrogate (Int)', :rule<first-line>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Astrogate is valid first line';
    is $match<name>, "Astrogate", '... named Astrogate';
    is $match<attribute>, "(Int)", '... based on Int';
}

{
    my $match = SWCA::Skill::Grammar.parse('Scoundrel, Scout, Soldier, Tech Specialist', :rule<second-line>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Classes are valid';
    is $match<name>[0], "Scoundrel",       '... and are Scoundrel';
    is $match<name>[1], "Scout",           '...         Scout';
    is $match<name>[2], "Soldier",         '...         Soldier';
    is $match<name>[3], "Tech Specialist", '...     and Tech Specialist';
}

{
    my $skill = q:to/END/.chop;
                    Astrogate (Int)
                    Scoundrel, Scout, Soldier, Tech Specialist
                    END
    dd $skill;
    my $match = SWCA::Skill::Grammar.parse($skill, :rule<skill>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Astrogate is valid skill';
    is $match<first-line><name>, "Astrogate", '... named Astrogate';
    is $match<first-line><attribute>, "(Int)", '... based on Int';
    is $match<second-line><name>[0], "Scoundrel", '... for Scoundrel';
    is $match<second-line><name>[3], "Tech Specialist", '... for Tech Specialist (etc)';
}

{
    my $match = SWCA::Character::Grammar.parse('Int: 9', :rule<attribute>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Valid attribute';
    is $match<attribute-name>, "Int", '... named Int';
    is $match<attribute-score>, "9", "... value 9";
}


done-testing;
