<section>
  <h2>Instilation</h2>
  <p>
    To run this program will require ruby 2.7 and RSpec 3.10
  </p>
  <p>
    After unpacking the program, navigate into the parseTXT-ruby directory and run the comand <code>$ ruby ./app/parse.rb &lt; TXT FILE PATH &gt;</code>
  </p>
  <p>
    The solution should apear printed to the terminal.
  </p>
</section>

<section>
  <h2>My Approach</h2>
  <p>
    When I got this problem statement, these were my guiding questions:
  </p>
  <ol>
      <li>From a user's perspective, what is the problem really asking? (break it down)</li>
      <li>What are my assumptions?</li>
      <li>What will I need to test to make sure it works?</li>
      <li>What pieces I have already written can I use to help me?</li>
    </ol>
</section>

<section>
  <h3>1. What is the problem really asking? (break it down)</h3>
  <p>
    Take an input file, do some stuff with the data, spit back out intellegent analysis in a specified order. So there are 3/4 parts of this problem:
    <ol>
      <li>Take an input file and parse through it.</li>
      <li>Model the data appropriately.</li>
      <li>Use those models to do some calculations.</li>
      <li>Sort the data and present it back to the user in the desired format.</li>
    </ol> 
  </p>
  <p>
    Bam. Leave it to Ruby to have exactly what what we need to accept input files baked into the program - ARGV and ARGF. ARGF looks like it will do exactly what I need it to do by assuming that each input after the Ruby file is a file name/path itself and then using the each_line method to go through line by line is perfect. I could have used ARGV to accept the file path as a variable and then pass it to File.foreach(file).each, but I thought the ARGF was cleaner and a simple comment line in the code would be sufficent to explain to others not familiar with ARGF what is happening. Next it's just splitting each line at the whitespace and casing through based on the first element.
  </p>
  <p>
    There are two types of entries, drivers and trips. These will clearly be our two models. If I were in Rails, I would join these two tables with Driver "has_many" Trips and each Trip "belongs_to" Driver. But we are in plain ruby and the belongs_to relationship is a Rails construct, I believe. I'll think on that and get back to it. Let's flush out what each model needs.
  </p>
  <p>
    To calculate speed, I can either take total miles divided by total time, or I can take each individual trip speed and divide it by the number of trips. I think the total miles and total time would take up less storage and produce a more accurate result than computing with average speeds so I'll do it that way. So on the Driver model I'll need:
  </p>
  <p>
    Drivers:
    <ul>
      <li>
        instance variables
        <ul>
          <li>name</li>
          <li>total miles driven</li>
          <li>total time driven</li>
          <li>average speed across trips</li>
        </ul>
      </li>
      <li>
        instance methods - what each driver should be able to do with their own data
        <ul>
          <li>the ability to add miles</li>
          <li>the ability to add time</li>
          <li>the ability to calculate speed</li>
        </ul>
      </li>
      <li>
        class methods - what I should do with all drivers collectively
        <ul>
          <li>the ability to lookup a driver by name</li>
          <li>the ability to sort the drivers</li>
          <li>to have those abilites, we need to store these instances of Driver into an array</li>
        </ul>
      </li>
    </ul>
    
    On the Trip side of things, I'll need:
    <ul>
      <li>
        instance variables
        <ul>
          <li>name</li>
          <li>start time</li>
          <li>end time</li>
          <li>total time (I don't <em>need</em> it, but I think it would be useful and more clear)
          <li>miles driven</li>
          <li>trip speed</li>
        </ul>
      </li>
      <li>
        instance methods - what each driver should be able to do with their own data
        <ul>
          <li>the ability to calculate speed (to know if the trip is valid)</li>
          <li>the ability to turn start/end time into a total time</li>
          <li>the ability to calculate</li>
        </ul>
      </li>
      <li>
        class methods - what I should do with all Trips collectively
        <ul>
          <li>storing each trip in a class array would be a convienent way of accessing and iterating through each Trip.</li>
        </ul>
      </li>
    </ul>

  </p>
  <p>
    I notice that I am calculating speed on both the Trip and the Driver. I could make a small Module that is calculate_speed that takes in time and miles and include it on both classes. I'll come back to this later.
  </p>
  <p>
    After I get the data instantiated correctly, I just need to iterate through each instance of Trip to filter out the invalid trips, look up the correct Driver associated with that trip, and to that instance's total time and miles.
  </p>
  <p>
    After each Driver has been updated, I'll use the Driver.sort method to arrange the Drivers from most miles driven to fewest miles driven. Then, I'll each over that array puts-ing out each driver in the desired format - paying additional attention to the case of a Driver logged with no miles.
  </p>
</section>

<section>
  <h2>2. What am I assuming?</h2>
  <p>
    My assumptions:
    <ul>
      <li>User wants to run program from command line - the <a src="https://github.com/turonn/parseTXT-rails" target="_blank">rails app</a> I orriginally made for this solution is <em>too</em> overkill.</li>
      <li>The user will import the correct file type and format.</li>
      <li>The user will not make any typos, have any name variants, or time variations.</li>
      <li>Everything will appear exactly as presented in the problem statement</li>
    </ul>
  </p>
</section>

<section>
  <h2>3. What will I need to test to make sure it works?</h2>
  <p>
    I'll need to test each method in each class isolated and then test the program as a whole. I'm not certain yet if I want make the module to calculate speed just yet, but I'll need to test that, too. Finally, I'll need to figure a way to test the program as a whole in RSpec.
  </p>
  <p>
    I'll use the RSpec testing suite because that is what Root uses to test their Ruby.
  </p>
</section>

<section>
  <h2>4. What pieces I have already written can I use to help me?</h2>
  <p>
    When I first approached the problem, I went full ham and built <a src="https://github.com/turonn/parseTXT-rails" target="_blank">a full rails application</a>. I built in data validations to protect the user from entering in invalid formats, wrote Rails-enabled relations betweeen models, alerted the users to updates, made it possible to CRUD single records and drivers through an interface, tested the whole thing with RSpec, and gave the app a clean Root-inspired styling interface. After completing the app, I spent time reflecting and asking my mentor and other coding friends about my critical assumption that the user (evaluator) would be okay interacting with a Rails interface instead of the command line as was requested. In the end, I decieded to go back and rebuild a program that more closely aligns with the requested result from the problem.
  </p>
  <p>
    As such, I had nearly all of the logic for this current version alreday written for this version! It was a matter of reapplying and retesting what I knew worked.
  </p>
</section>