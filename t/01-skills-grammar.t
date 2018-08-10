use sw_d20_character_aid;
use Test;

{
    my $match = SWCA::Skill.parse('Appraise', :rule<name>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Appraise is valid first line';
    is $match, "Appraise", '... named Appraise';
}

{
    my $match = SWCA::Skill.parse('Appraise (Int) Untrained', :rule<first-line>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Appraise is valid first line';
    is $match<name>, "Appraise", '... named Appraise';
    is $match<attribute>, "(Int)", '... based on Int';
    is $match<modifier>[0], "Untrained", '... and usuable untrained"';
}

{
    my $match = SWCA::Skill.parse('Move Object', :rule<name>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Move Object is valid first line';
    is $match, "Move Object", '... named Move Object';
}

{
    my $match = SWCA::Skill.parse('Move Object (Int) Force Untrained', :rule<first-line>);
    isa-ok $match, Match, 'Got a match';
    ok $match,  'Move Object is valid first line';
    is $match<name>, "Move Object", '... named Move Object';
    is $match<attribute>, "(Int)", '... based on Int';
    is $match<modifier>[0], "Force", '... a force skill"';
    is $match<modifier>[1], "Untrained", '... and usuable untrained"';
}

done-testing;
